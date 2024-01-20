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

enum SingingCharacter { completed, uncompleted }

class AddNoteWidget extends StatefulWidget {
  const AddNoteWidget({
    super.key,
  });

  @override
  State<AddNoteWidget> createState() => _AddNoteWidgetState();
}

class _AddNoteWidgetState extends State<AddNoteWidget> {
  final GlobalKey<FormState> formkey = GlobalKey();
  String? title, content, image;
  bool isCompleted = false;
  late File? _image = null;
  AutovalidateMode autovalidate = AutovalidateMode.disabled;
  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      autovalidateMode: autovalidate,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            onsaved: (data) {
              title = data;
            },
            text: 'title',
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextField(
            onsaved: (data) {
              content = data;
            },
            text: 'content',
            maxlines: 5,
          ),
          const SizedBox(
            height: 26,
          ),
          _image != null
              ? Image.file(
                  _image!,
                  height: 100,
                )
              : Container(),
          ElevatedButton(
            onPressed: _getImage,
            child: Text('Take Photo'),
          ),
          const SizedBox(
            height: 26,
          ),
          Row(
            children: [
              Checkbox(
                value: isCompleted,
                onChanged: (bool? value) {
                  setState(() {
                    isCompleted = value != null ? value : false;
                  });
                },
              ),
              Text('Task Completed'),
            ],
          ),
          const ColorListview(),
          const SizedBox(
            height: 70,
          ),
          BlocBuilder<AddNoteCubit, AddNoteState>(
            builder: (context, state) {
              return CustomButton(
                isLoading: state is AddNoteLoading ? true : false,
                onpressed: () {
                  if (formkey.currentState!.validate()) {
                    formkey.currentState!.save();
                    var currentDate = DateTime.now();
                    var formattedCurrentDate =
                        DateFormat.yMEd().format(currentDate);
                    var notemodel = NoteModel(
                        title: title!,
                        subTitle: content!,
                        date: formattedCurrentDate,
                        image:
                            _image?.path ?? '', // Use image path if available
                        color: Colors.black.value,
                        status: isCompleted);
                    BlocProvider.of<AddNoteCubit>(context).addNote(notemodel);
                  } else {
                    autovalidate = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
