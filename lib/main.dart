import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/cubits/read_note/read_notes_cubit.dart';
import 'package:notes_app/firebase_options.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:notes_app/screens/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/screens/login.dart';
import 'package:notes_app/simple_bloc_observer.dart';
import 'constants/constants.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(knotesbox);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReadNotesCubit(),
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Poppins',
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: LoginPage.id,
        routes: {
          LoginPage.id: (context) => const LoginPage(),
          HomePage.id: (context) => const HomePage(),
        },
      ),
    );
  }
}
