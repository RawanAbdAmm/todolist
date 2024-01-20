import 'package:flutter/material.dart';
import 'package:notes_app/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.text,
    this.maxlines = 1,
    this.onsaved, this.onChanged,
  });
  final String text;
  final int maxlines;
  final void Function(String?)? onsaved;
 final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onSaved: onsaved,
        validator: (data) {
          if (data?.isEmpty ?? true) {
            return 'Field is required';
          } else {
            return null;
          }
        },
        onChanged:onChanged ,
        cursorColor: kprimarycolor,
        maxLines: maxlines,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: const TextStyle(color: kprimarycolor),
          border: buildborder(),
          enabledBorder: buildborder(),
          focusedBorder: buildborder(color: kprimarycolor),
        ));
  }

  OutlineInputBorder buildborder({color}) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: color ?? Colors.white),
      );
}
