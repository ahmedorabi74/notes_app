import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notesss_app/views/edit_note_view.dart';
import 'package:notesss_app/widgets/custom_search_icon.dart';

import '../models/note_model.dart';

class ViewFullNoteView extends StatelessWidget {
  const ViewFullNoteView({super.key, required this.noteModel});

  final NoteModel noteModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blue,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.h,
            ),
            appBar(context),
            SizedBox(
              height: 40.h,
            ),
            Expanded(child: body()),
          ],
        ),
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            textAlign: TextAlign.start,
            noteModel.title,
            style: TextStyle(color: Colors.white, fontSize: 35.sp),
          )
              .animate()
              .shimmer(duration: 2.seconds, color: Color(noteModel.color)),

          SizedBox(
            height: 40.h,
          ),
          SelectableText(  textAlign: TextAlign.start,
            noteModel.subTitle,
            style: TextStyle(color: Colors.white, fontSize: 22.sp),
          )
        ],
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return Row(
      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIcon(
          onTap: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            'assets/images/backArrow.svg',
            width: 14.w, // Optional: Set width
          ),
        ),
        const Spacer(),
        CustomIcon(
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return EditNoteView(noteModel: noteModel);
            }));
          },
          icon: SvgPicture.asset(
            'assets/images/edit.svg',
            width: 21.w, // Optional: Set width
          ),
        ),
      ],
    );
  }
}
