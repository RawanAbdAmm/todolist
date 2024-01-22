import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/read_note/read_notes_cubit.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:notes_app/widgets/customwidgets/custom_card.dart';

class NotesListview extends StatelessWidget {
  const NotesListview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadNotesCubit, ReadNoteState>(
      builder: (context, state) {
        if (state is ReadNotesSuccessState) {
          List<NoteModel>? notes = state.notes;

          if (notes != null) {
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return NoteItem(
                  note: notes[index],
                );
              },
            );
          }
        }

        // Return an empty container or some other placeholder widget
        return Container();
      },
    );
  }
}
