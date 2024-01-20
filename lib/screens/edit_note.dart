import 'package:flutter/material.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:notes_app/widgets/bodywidgets/edit_notewidget.dart';


class EditNote extends StatelessWidget {
  const EditNote({super.key, required this.note});
  static String id="EditNote";
final NoteModel note;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: EditNoteBody(note: note,),
    );
  }
}
