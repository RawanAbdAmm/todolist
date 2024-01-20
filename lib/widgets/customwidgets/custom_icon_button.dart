import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.icon, this.onpressed,
  });
  final Icon icon;
  final void Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
          color: const Color.fromARGB(83, 158, 158, 158),
          borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: IconButton(onPressed: onpressed,icon: icon,splashRadius:22 ,),
      ),
    );
  }
}
