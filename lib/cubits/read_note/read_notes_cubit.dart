import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/model/note_model.dart';

part 'read_notes_state.dart';

class ReadNotesCubit extends Cubit<ReadNoteState> {
  ReadNotesCubit() : super(ReadNotesInitialState());

  Future<void> readAllNotes() async {
    try {
      emit(ReadNotesLoadingState());

      String? userId = FirebaseAuth.instance.currentUser?.uid;

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('notes')
              .get();

      List<NoteModel> notes = querySnapshot.docs
          .map((doc) => NoteModel.fromFirestore(doc.data()))
          .toList();

      emit(ReadNotesSuccessState(notes));
    } catch (e) {
      emit(ReadNotesFailureState(e.toString()));
    }
  }
}
class UpdateNoteState extends ReadNoteState {
  final NoteModel updatedNote;

  UpdateNoteState(this.updatedNote);
}
