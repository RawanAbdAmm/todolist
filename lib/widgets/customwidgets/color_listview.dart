import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/constants/constants.dart';
import 'package:notes_app/cubits/add_note/add_note_cubit.dart';

class ColorItem extends StatelessWidget {
  const ColorItem(
      {super.key, required this.colorIsActive, required this.color});
  final bool colorIsActive;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return colorIsActive
        ? CircleAvatar(
            radius: 26,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 24,
              backgroundColor: color,
            ),
          )
        : CircleAvatar(
            radius: 26,
            backgroundColor: color,
          );
  }
}

class ColorListview extends StatefulWidget {
  const ColorListview({super.key});

  @override
  State<ColorListview> createState() => _ColorListviewState();
}

class _ColorListviewState extends State<ColorListview> {
  int currentIndex = 0;
 
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
                  BlocProvider.of<AddNoteCubit>(context).color=colors[index];
                  setState(() {
                    
                  });
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
