import 'package:hive/hive.dart';
part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  final String date;
  @HiveField(2)
  String subTitle;
  @HiveField(3)
  int color;
  @HiveField(4)
  String image;


  NoteModel(
      {required this.title,
      required this.date,
      required this.subTitle,
      required this.color,required this.image});
}
