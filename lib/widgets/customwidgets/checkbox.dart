import 'package:flutter/material.dart';

enum status { completed, uncompleted }

class Radiowidget extends StatefulWidget {
  const Radiowidget({super.key, required this.onValueChanged});
  final void Function(status) onValueChanged;

  @override
  State<Radiowidget> createState() => _RadioState();
}

class _RadioState extends State<Radiowidget> {
  status? _character = status.uncompleted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Completed'),
          leading: Radio<status>(
            value: status.completed,
            groupValue: _character,
            onChanged: (status? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Uncompleted'),
          leading: Radio<status>(
            value: status.uncompleted,
            groupValue: _character,
            onChanged: (status? value) {
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
