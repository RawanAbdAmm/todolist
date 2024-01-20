import 'package:flutter/material.dart';

enum SingingCharacter { completed, uncompleted }

class Radiowidget extends StatefulWidget {
  const Radiowidget({super.key, required this.onValueChanged});
  final void Function(SingingCharacter) onValueChanged;

  @override
  State<Radiowidget> createState() => _RadioState();
}

class _RadioState extends State<Radiowidget> {
  SingingCharacter? _character = SingingCharacter.uncompleted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Completed'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.completed,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Uncompleted'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.uncompleted,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
