import 'package:flutter/material.dart';
import 'package:notes_app/widgets/bodywidgets/add_notebottomsheet.dart';
import 'package:notes_app/widgets/bodywidgets/notes_body_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static String id = 'Homepage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            builder: (context) {
              return const AddNoteBottomsheet();
            },
          );
        },
        splashColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 46, 45, 45),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: const NotesViewBody(),
    );
  }
}
