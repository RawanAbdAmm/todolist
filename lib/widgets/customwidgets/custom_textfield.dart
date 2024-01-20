
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labeltext;
  final Icon icon;
  final bool visible;
  Function(String)? onchanged;
  final double? width;

   CustomTextField(
      {super.key,
      required this.labeltext,
      required this.icon,
      required this.visible,this.onchanged,this.width});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width??350,
      child: TextFormField(

        validator: (value) {
          if(value!.isEmpty){
            return 'Field Can\'t be empty';
          }
          return null;

        },
        onChanged: onchanged,
        obscureText: visible,
        decoration: InputDecoration(
          labelText: labeltext,
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
