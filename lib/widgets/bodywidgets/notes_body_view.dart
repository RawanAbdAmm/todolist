import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/read_note/read_notes_cubit.dart';
import 'package:notes_app/widgets/bodywidgets/notes_listview.dart';
import 'package:notes_app/widgets/customwidgets/custom_appbar.dart';

class NotesViewBody extends StatefulWidget {
  const NotesViewBody({
    Key? key,
  }) : super(key: key);

  @override
  State<NotesViewBody> createState() => _NotesViewBodyState();
}

class _NotesViewBodyState extends State<NotesViewBody> {
  @override
  void initState() {
    BlocProvider.of<ReadNotesCubit>(context).readAllNotes();
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // User signed out
        print("User signed out");
      } else {
        // User signed in
        print("User signed in: ${user.uid}");
      }
    });
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Column(
        children: [
         const SizedBox(
            height: 20,
          ),
          CustomAppbar(
            title: '  To Do list',

            icon: const Icon(Icons.exit_to_app), // Sign-out icon
            onpressed: _signOut,
          ),
         const SizedBox(
            height: 30,
          ),
          Expanded(child: NotesListview()),
        ],
      ),
    );
  }
}
