import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String question;
  final String nameofbutton;

  final VoidCallback? onpressed;

  const CustomButton({
    super.key,
    this.onpressed,
    required this.question,
    required this.nameofbutton,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(question),
        TextButton(
            onPressed: onpressed,
            child: Text(
              nameofbutton,
              style: const TextStyle(color: Color.fromARGB(255, 57, 152, 231),fontSize: 16),
            ))
      ],
    );
  }
}
