import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/read_note/read_notes_cubit.dart';
import 'package:notes_app/widgets/bodywidgets/notes_listview.dart';
import 'package:notes_app/widgets/customwidgets/custom_appbar.dart';

class NotesViewBody extends StatefulWidget {
  const NotesViewBody({
    super.key,
  });

  @override
  State<NotesViewBody> createState() => _NotesViewBodyState();

}

class _NotesViewBodyState extends State<NotesViewBody> {
  @override
  void initState() {
    BlocProvider.of<ReadNotesCubit>(context).readAllNotes();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          CustomAppbar(
            title: '  To Do list',
            icon: Icon(Icons.search_outlined),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(child: NotesListview()),
        ],
      ),
    );
  }
}
