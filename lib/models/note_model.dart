import 'package:hive/hive.dart';



@HiveType(typeId: 0) // id for all class
class NoteModel extends HiveObject {
  @HiveField(0) // id for that element,unique per class !
  String title;
  @HiveField(1)
  String subTitle;
  @HiveField(2)
  final String date;
  @HiveField(3)
  int color;
  @HiveField(4)
  bool isImportant;

  NoteModel(
      {required this.title,
      required this.subTitle,
      required this.date,
      required this.color,
      this.isImportant=false});
}
