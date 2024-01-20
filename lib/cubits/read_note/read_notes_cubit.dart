import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/constants/constants.dart';
import 'package:notes_app/model/note_model.dart';

part 'read_notes_state.dart';

class ReadNotesCubit extends Cubit<ReadNoteState> {
  ReadNotesCubit() : super(ReadNotesInitialState());
  List<NoteModel>? notes;
  readAllNotes() {
    var notesBox = Hive.box<NoteModel>(knotesbox);
    notes = notesBox.values.toList();
    emit(ReadNotesSuccessState());
  }
}
