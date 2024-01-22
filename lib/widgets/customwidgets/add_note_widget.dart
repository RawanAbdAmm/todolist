import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/cubits/add_note/add_note_cubit.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:notes_app/widgets/customwidgets/color_listview.dart';
import 'package:notes_app/widgets/customwidgets/custom_button.dart';
import 'package:notes_app/widgets/customwidgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddNoteWidget extends StatefulWidget {
  const AddNoteWidget({Key? key}) : super(key: key);

  @override
  State<AddNoteWidget> createState() => _AddNoteWidgetState();
}

class _AddNoteWidgetState extends State<AddNoteWidget> {
  final GlobalKey<FormState> formkey = GlobalKey();
  String? title, content, image;
  bool isCompleted = false;
   File? _image;
  AutovalidateMode autovalidate = AutovalidateMode.disabled;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _addNoteToFirestore(NoteModel noteModel) async {
    String? userId = _auth.currentUser?.uid;

    await _firestore.collection('users').doc(userId).collection('notes').add({
      'title': noteModel.title,
      'subTitle': noteModel.subTitle,
      'date': noteModel.date,
      'image': noteModel.image,
      'color': noteModel.color,
      'status': noteModel.status,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      autovalidateMode: autovalidate,
      child: Column(
        children: [
          const SizedBox(height: 20),
          CustomTextField(
            onsaved: (data) {
              title = data;
            },
            text: 'title',
          ),
          const SizedBox(height: 15),
          CustomTextField(
            onsaved: (data) {
              content = data;
            },
            text: 'content',
            maxlines: 5,
          ),
          const SizedBox(height: 26),
          _image != null
              ? Image.file(
                  _image!,
                  height: 100,
                )
              : Container(),
          ElevatedButton(
            onPressed: _getImage,
            child:const Text('Take Photo'),
          ),
          const SizedBox(height: 26),
          Row(
            children: [
              Checkbox(
                value: isCompleted,
                onChanged: (bool? value) {
                  setState(() {
                    isCompleted = value ?? false;
                  });
                },
              ),
             const Text('Task Completed'),
            ],
          ),
          const ColorListview(),
          const SizedBox(height: 70),
          BlocBuilder<AddNoteCubit, AddNoteState>(
            builder: (context, state) {
              return CustomButton(
                isLoading: state is AddNoteLoading,
                onpressed: () async {
                  if (formkey.currentState!.validate()) {
                    formkey.currentState!.save();
                    var currentDate = DateTime.now();
                    var formattedCurrentDate =
                        DateFormat.yMEd().format(currentDate);
                    var notemodel = NoteModel(
                      title: title!,
                      subTitle: content!,
                      date: formattedCurrentDate,
                      image: _image?.path ?? '',
                      color: Colors.black.value,
                      status: isCompleted,
                    );

                    await _addNoteToFirestore(notemodel);

                    // After adding the note to Firestore, you can also dispatch a Bloc event if needed
                    BlocProvider.of<AddNoteCubit>(context).addNote(notemodel);
                  } else {
                    autovalidate = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
