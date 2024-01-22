import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app/cubits/read_note/read_notes_cubit.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:notes_app/widgets/customwidgets/custom_appbar.dart';
import 'package:notes_app/widgets/customwidgets/custom_text_field.dart';
import 'package:notes_app/widgets/customwidgets/edit_colorlist.dart';

class EditNoteBody extends StatefulWidget {
  const EditNoteBody({
    super.key,
    required this.note,
  });
  final NoteModel note;

  @override
  State<EditNoteBody> createState() => _EditNoteBodyState();
}

class _EditNoteBodyState extends State<EditNoteBody> {
  bool? isCompleted;
  late File? _image = null;

  String? title, content;

  @override
  Widget build(BuildContext context) {
    Future<void> _getImage() async {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            CustomAppbar(
              onpressed: () {
                widget.note.title = title ?? widget.note.title;
                widget.note.subTitle = content ?? widget.note.subTitle;
                widget.note.status = isCompleted ?? widget.note.status;
                widget.note.image=_image == null
                    ? widget.note.image
                    : _image!.path;
                // widget.note.save();
                BlocProvider.of<ReadNotesCubit>(context).readAllNotes();
                Navigator.pop(context);
              },
              title: ' Edit To-do-Note',
              icon: const Icon(Icons.done),
            ),
            const SizedBox(
              height: 60,
            ),
            CustomTextField(
              onChanged: (data) {
                title = data;
              },
              text: widget.note.title,
            ),
            const SizedBox(
              height: 25,
            ),
            CustomTextField(
              onChanged: (data) {
                content = data;
              },
              text: widget.note.subTitle,
              maxlines: 5,
            ),
            const SizedBox(
              height: 25,
            ),
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
            Row(
              children: [
                Checkbox(
                  value: isCompleted ?? widget.note.status,
                  onChanged: (bool? value) {
                    setState(() {
                      isCompleted = value;
                    });
                  },
                ),
                Text(
                    isCompleted == true ? 'Task Completed' : 'Task Incomplete'),
              ],
            ),
            EditNotColorListview(
              note: widget.note,
            )
          ],
        ),
      ),
    );
  }
}
