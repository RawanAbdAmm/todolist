import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/cubits/add_note/add_note_cubit.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:notes_app/widgets/customwidgets/checkbox.dart';
import 'package:notes_app/widgets/customwidgets/color_listview.dart';
import 'package:notes_app/widgets/customwidgets/custom_button.dart';
import 'package:notes_app/widgets/customwidgets/custom_text_field.dart';

class AddNoteWidget extends StatefulWidget {
  const AddNoteWidget({
    super.key,
  });

  @override
  State<AddNoteWidget> createState() => _AddNoteWidgetState();
}

class _AddNoteWidgetState extends State<AddNoteWidget> {
  final GlobalKey<FormState> formkey = GlobalKey();
  String? title, content, image;
  SingingCharacter? selectedValue = SingingCharacter.uncompleted;

  AutovalidateMode autovalidate = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      autovalidateMode: autovalidate,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            onsaved: (data) {
              title = data;
            },
            text: 'title',
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextField(
            onsaved: (data) {
              content = data;
            },
            text: 'content',
            maxlines: 5,
          ),
          const SizedBox(
            height: 26,
          ),
          CustomTextField(
            onsaved: (data) {
              image = data;
            },
            text: 'image'
          ),
       
          const SizedBox(
            height: 26,
          ),
          const ColorListview(),
          Radiowidget(
            onValueChanged: (value) {
              setState(() {
                selectedValue = value;
              });
              print(selectedValue);
            },
          ),
          const SizedBox(
            height: 70,
          ),
          BlocBuilder<AddNoteCubit, AddNoteState>(
            builder: (context, state) {
              return CustomButton(
                isLoading: state is AddNoteLoading ? true : false,
                onpressed: () {
                  if (formkey.currentState!.validate()) {
                    formkey.currentState!.save();
                    var currentDate = DateTime.now();
                    var formattedCurrentDate =
                        DateFormat.yMEd().format(currentDate);
                    var notemodel = NoteModel(
                        title: title!,
                        subTitle: content!,
                        date: formattedCurrentDate,
                        image: image!,
                        // isCompleted: selectedValue,
                        color: Colors.black.value);
                    BlocProvider.of<AddNoteCubit>(context).addNote(notemodel);
                  } else {
                    autovalidate = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
