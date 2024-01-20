
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final bool isLoading;

  final VoidCallback? onpressed;

  const CustomButton({
    super.key,
    this.onpressed,
    required this.isLoading,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      
        TextButton(onPressed:onpressed, child: Text('Add'))
      ],
    );
  }
}
