import 'package:flutter/material.dart';
import 'package:notes_app/constants/constants.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:notes_app/widgets/customwidgets/color_listview.dart';

class EditNotColorListview extends StatefulWidget {
  const EditNotColorListview({super.key, required this.note});
  final NoteModel note;

  @override
  State<EditNotColorListview> createState() => _EditNotColorListview();
}

class _EditNotColorListview extends State<EditNotColorListview> {
late  int currentIndex ;

  @override
  void initState() {
    currentIndex=colors.indexOf(Color(widget.note.color));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26 * 2,
      child: ListView.builder(
          itemCount: colors.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: InkWell(
                borderRadius: BorderRadius.circular(26),
                onTap: () {
                  currentIndex = index;
                  widget.note.color=colors[index].value;
                  setState(() {});
                },
                child: ColorItem(
                  colorIsActive: currentIndex == index,
                  color: colors[index],
                ),
              ),
            );
          }),
    );
  }
}
