import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/read_note/read_notes_cubit.dart';
import 'package:notes_app/model/note_model.dart';

class ListtileDesign extends StatelessWidget {
  const ListtileDesign({
    super.key,
    required this.note,
  });
  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // CircleAvatar(child: Image(image: AssetImage(note.image)),),
      Text(
        note.status == true ? 'Completed Task' : 'Not Completed',
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      ListTile(
        title: Text(
          note.title,
          style: const TextStyle(
              fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16),
          child: Text(
            note.subTitle,
            style: const TextStyle(
                fontSize: 18, color: Color.fromARGB(124, 0, 0, 0)),
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            note.delete();
            BlocProvider.of<ReadNotesCubit>(context).readAllNotes();
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.black,
            size: 27,
          ),
        ),
      ),
    ]);
  }
}
