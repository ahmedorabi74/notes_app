import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notesss_app/constans.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
       this.hintText='',
      this.maxLines = 1,
      this.onSaved,
      this.onChanged,
      this.initialValue = '', this.cursorColor});

   final String? hintText;
  final int maxLines;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final String? initialValue;
  final Color? cursorColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: (value) {
        if ((value?.trim().isEmpty ?? true)) {
          return 'Field is required';
        }
        else {
          return null;
        }
      },
      cursorColor: cursorColor,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: kPrimaryColor),
        border: buildOutlineInputBorder(),
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(kPrimaryColor),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder([color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: color ?? Colors.white),
    );
  }
}
