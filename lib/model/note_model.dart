
class NoteModel {
   String title;
   String subTitle;
  final String date;
   String image;
   int color;
   bool status;

  NoteModel({
    required this.title,
    required this.subTitle,
    required this.date,
    required this.image,
    required this.color,
    required this.status,
  });

  // Factory method to convert Firestore data to NoteModel
  factory NoteModel.fromFirestore(Map<String, dynamic> data) {
    return NoteModel(
      title: data['title'],
      subTitle: data['subTitle'],
      date: data['date'],
      image: data['image'],
      color: data['color'],
      status: data['status'],
    );
  }
}
