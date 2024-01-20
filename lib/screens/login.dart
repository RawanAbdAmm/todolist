// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:notes_app/helper/showdialog.dart';
import 'package:notes_app/screens/home_page.dart';
import 'package:notes_app/screens/registerScreen.dart';
import 'package:notes_app/widgets/customwidgets/custom_buutton.dart';
import 'package:notes_app/widgets/customwidgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'Loginpage';

  @override
  State<LoginPage> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  String? email, password;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: width < 600
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Login ',
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                            Text(
                              'Up',
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Color.fromARGB(255, 57, 152, 231)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        CustomTextField(
                          onchanged: (data) {
                            email = data;
                          },
                          labeltext: 'Email',
                          icon: const Icon(Icons.email_outlined),
                          visible: false,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          onchanged: (data) {
                            password = data;
                          },
                          labeltext: 'Password',
                          icon: const Icon(Icons.password_outlined),
                          visible: true,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 57, 152, 231)),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                String errorMessage = '';

                                try {
                                  await SigninUserwithEmailandPass();
                                  Navigator.pushNamed(context, HomePage.id,
                                      arguments: email);
                                  isLoading = true;
                                  setState(() {});
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'invalid-credential') {
                                    errorMessage =
                                        ('Email or password is wrong');
                                  }

                                  isLoading = false;

                                  setState(() {});

                                  showerrmsg(
                                      context, 'Login Error', errorMessage);
                                }
                              } else {}
                            },
                            child: const Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            )),
                        CustomButton(
                          question: 'don\'t have an account?',
                          nameofbutton: 'Sign Up',
                          onpressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (ctx) => const RegisterScreen()),
                            );
                          },
                        )
                      ],
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Login ',
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                            Text(
                              'Up',
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Color.fromARGB(255, 57, 152, 231)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextField(
                          width: 500,
                          onchanged: (data) {
                            email = data;
                          },
                          labeltext: 'Email',
                          icon: const Icon(Icons.email_outlined),
                          visible: false,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          width: 500,
                          onchanged: (data) {
                            password = data;
                          },
                          labeltext: 'Password',
                          icon: const Icon(Icons.password_outlined),
                          visible: true,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                          
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                   const Color.fromARGB(255, 57, 152, 231)),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                String errorMessage = '';

                                try {
                                  await ();
                                  Navigator.pushReplacementNamed(context, HomePage.id,
                                      arguments: email);
                                  isLoading = true;
                                  setState(() {});
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'invalid-credential') {
                                    errorMessage =
                                        ('Email or password is wrong');
                                  }

                                  isLoading = false;

                                  setState(() {});

                                  showerrmsg(
                                      context, 'Login Error', errorMessage);
                                }
                              } else {}
                            },
                            child: const Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            )),
                        CustomButton(
                          question: 'don\'t have an account?',
                          nameofbutton: 'Sign Up',
                          onpressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (ctx) => const RegisterScreen()),
                            );
                          },
                        )
                      ],
                    )),
        ),
      ),
    );
  }

  Future<void> SigninUserwithEmailandPass() async {
    UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
