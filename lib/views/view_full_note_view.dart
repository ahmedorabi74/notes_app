import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:notesss_app/views/edit_note_view.dart';
import 'package:notesss_app/widgets/custom_search_icon.dart';

import '../models/note_model.dart';

class ViewFullNoteView extends StatelessWidget {
  const ViewFullNoteView({super.key, required this.noteModel});

  final NoteModel noteModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            appBar(context),
            SizedBox(height: 40.h),
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

          SizedBox(height: 40.h),

          // Updated subtitle with link detection
          SelectableText.rich(
            _buildTextSpans(noteModel.subTitle),
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.white, fontSize: 22.sp),
          ),
        ],
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return Row(
      children: [
        CustomIcon(
          onTap: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            'assets/images/backArrow.svg',
            width: 14.w,
          ),
        ),
        const Spacer(),
        CustomIcon(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return EditNoteView(noteModel: noteModel);
            }));
          },
          icon: SvgPicture.asset(
            'assets/images/edit.svg',
            width: 21.w,
          ),
        ),
      ],
    );
  }

  /// Function to detect and format links inside text
  TextSpan _buildTextSpans(String text) {
    /// reg x to detect links in text
    final RegExp linkRegExp = RegExp(
      r'(https?:\/\/[^\s]+|www\.[^\s]+)',
      caseSensitive: false,
    );

    final List<TextSpan> spans = [];
    int start = 0;

    for (final Match match in linkRegExp.allMatches(text)) {
      if (match.start > start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }

      final String url = match.group(0)!;
      spans.add(
        TextSpan(
          text: url,
          style: TextStyle(
              color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL(url),
        ),
      );

      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }

    return TextSpan(children: spans);
  }

  /// Opens the detected URL in the browser
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url.startsWith("http") ? url : "https://$url");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
