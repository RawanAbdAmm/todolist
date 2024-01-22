part of 'read_notes_cubit.dart';

abstract class ReadNoteState {}

class ReadNotesInitialState extends ReadNoteState {}

class ReadNotesLoadingState extends ReadNoteState {}

class ReadNotesSuccessState extends ReadNoteState {
  final List<NoteModel>? notes;

  ReadNotesSuccessState(this.notes);
}

class ReadNotesFailureState extends ReadNoteState {
  final String error;

  ReadNotesFailureState(this.error);
}
// read_notes_cubit.dart


