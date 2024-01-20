import 'package:flutter/material.dart';
import 'package:notes_app/widgets/customwidgets/custom_icon_button.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
    required this.title,
    required this.icon, this.onpressed,
  });
  final String title;
  final Icon icon;
  final void Function()? onpressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 30),
        ),
        const Spacer(),
        CustomButton(
          onpressed:onpressed ,
          icon: icon,
        ),
      ],
    );
  }
}
