import 'package:flutter/cupertino.dart';
import 'package:notesss_app/widgets/colors_list_view.dart';

import '../constans.dart';
import '../models/note_model.dart';

class EditColorsList extends StatefulWidget {
  const EditColorsList({super.key, required this.noteModel});

  final NoteModel noteModel;

  @override
  State<EditColorsList> createState() => _EditColorsListState();
}

class _EditColorsListState extends State<EditColorsList> {
  late int currentIndex;

  @override
  void initState() {
    currentIndex = kColors.indexOf(Color(widget.noteModel.color));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38 * 2,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: kColors.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: GestureDetector(
                onTap: () {
                  currentIndex = index;
                  widget.noteModel.color = kColors[index].value;
                  setState(() {});
                },
                child: ColorItem(
                  color: kColors[index],
                  isChoose: currentIndex == index ? true : false,
                ),
              ),
            );
          }),
    );
  }
}
