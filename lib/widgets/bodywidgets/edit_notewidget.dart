import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/read_note/read_notes_cubit.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:notes_app/widgets/customwidgets/checkbox.dart';
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
  SingingCharacter? selectedValue;

  String? title, content;

  @override
  Widget build(BuildContext context) {
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
                // widget.note.isCompleted =
                //     selectedValue ?? widget.note.isCompleted;
                widget.note.save();
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
            Radiowidget(
              onValueChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
                print(selectedValue);
              },
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
