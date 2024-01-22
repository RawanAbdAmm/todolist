
import 'package:flutter/material.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:notes_app/screens/edit_note.dart';
import 'package:notes_app/widgets/customwidgets/listtile_design.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
    required this.note,
  });
  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>EditNote(note: note)));
        },
        child: Container(
          padding: const EdgeInsets.only(top: 24, bottom: 24, left: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color:Color( note.color),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ListtileDesign(
                note: note,
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: Text(
                  note.date,
                  style: const TextStyle(
                      color: Color.fromARGB(133, 189, 111, 111), fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
