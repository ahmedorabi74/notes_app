import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:notesss_app/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notesss_app/models/note_model.dart';

import '../cubits/add_note_cubit/add_note_state.dart';
import 'colors_list_view.dart';
import 'custom_button.dart';
import 'custom_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class AddNoteForm extends StatefulWidget {
  const AddNoteForm({
    super.key,
  });

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final GlobalKey<FormState> form = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: autovalidateMode,
      key: form,
      child: Column(
        children: [
           SizedBox(
            height: 32.h,
          ),
          CustomTextField(
            onSaved: (value) {
              title = value;
            },
            hintText: AppLocalizations.of(context)!.title,
          ),
           SizedBox(
            height: 16.h,
          ),
          CustomTextField(
            onSaved: (value) {
              subTitle = value;
            },
            hintText: AppLocalizations.of(context)!.content,
            maxLines: 5,
          ),
           SizedBox(
            height: 18.h,
          ),
          const ColorListView(),
           SizedBox(
            height: 18.h,
          ),
          BlocBuilder<AddNoteCubit, AddNoteState>(
            builder: (context, state) {
              return CustomButton(
                isLoading: state is AddNoteLoading ? true : false,
                onTap: () {
                  if (form.currentState!.validate()) {
                    form.currentState!.save();
                    var noteModel = NoteModel(
                        title: title!,
                        subTitle: subTitle!,
                        date: DateTime.now().toString(),
                        color: Colors.blue.value);
                    BlocProvider.of<AddNoteCubit>(context).addNote(noteModel);
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              );
            },
          ),
           SizedBox(
            height: 16.h,
          ),
        ],
      ),
    );

  }
}
