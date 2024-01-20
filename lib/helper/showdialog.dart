import 'package:flutter/material.dart';

void showerrmsg(BuildContext context, String titlemsg, String errorMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titlemsg),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child:const Text("OK"),
          ),
        ],
      );
    },
  );
}
