import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/helper/showdialog.dart';
import 'package:notes_app/widgets/customwidgets/custom_buutton.dart';
import 'package:notes_app/widgets/customwidgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;
  GlobalKey<FormState> formkey = GlobalKey();

  String? password;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              const SizedBox(
                height: 130,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign ',
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
              const Text(
                'Fill This Form to complete your account!',
              ),
              const Divider(
                endIndent: 15,
                thickness: 2,
                indent: 15,
                color: Color.fromARGB(255, 57, 152, 231),
              ),
              const SizedBox(
                height: 30,
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
                height: 25,
              ),
              const Divider(
                endIndent: 6,
                thickness: 2,
                indent: 6,
                color: Color.fromARGB(255, 57, 152, 231),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(79, 158, 158, 158),
                    borderRadius: BorderRadius.circular(30)),
                width: 400,
                height: 60,
                child: const Center(
                    child: Text(
                  'By clicking submit you agree on our Privacy Policy ',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                )),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 57, 152, 231)),
                  onPressed: () async {
                    setState(() {});
                    if (formkey.currentState!.validate()) {
                      String errorMessage = '';
    
                      try {
                        await CreateUserwithEmailandPass();
                        errorMessage = 'success';
                        Navigator.of(context).pop();
                    
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          errorMessage =
                              ('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          errorMessage =
                              ('The account already exists for that email.');
                        }
    
               
    
                        showerrmsg(
                            context, 'Registration Error', errorMessage);
                      }
                    } else {}
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  )),
              CustomButton(
                nameofbutton: 'Login',
                question: 'Already have account?',
                onpressed: () {
                  Navigator.of(context).pop();
                },
              )
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> CreateUserwithEmailandPass() async {
    UserCredential user =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
