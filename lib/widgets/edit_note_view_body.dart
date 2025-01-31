import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notesss_app/models/note_model.dart';
import 'package:notesss_app/widgets/custom_appbar.dart';
import 'package:notesss_app/widgets/custom_flushbar.dart';

import '../constans.dart';
import '../cubits/notes_cubit/notes_cubit.dart';
import 'colors_list_view.dart';
import 'custom_text_field.dart';
import 'edit_note_colors_list_view.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditNoteViewBody extends StatefulWidget {
  const EditNoteViewBody({super.key, required this.noteModel});

  final NoteModel noteModel;

  @override
  State<EditNoteViewBody> createState() => _EditNoteViewBodyState();
}

class _EditNoteViewBodyState extends State<EditNoteViewBody> {
  String? title, subTitle;

  void _editSound() async {
    final audioPlayer = AudioPlayer(); // Create a local instance
    await audioPlayer.play(AssetSource('sounds/edit.mp3'));
    await Future.delayed(const Duration(seconds: 2)); // Simulate Sound time
    audioPlayer.dispose(); // Dispose after use
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          CustomAppBAr(
            isHome: false,
            shimmerColor: Color(widget.noteModel.color),
            onPressed: () {
              widget.noteModel.title = title ?? widget.noteModel.title;
              widget.noteModel.subTitle = subTitle ?? widget.noteModel.subTitle;
              widget.noteModel.save();
              BlocProvider.of<NotesCubit>(context).fetchAllNotes();
              Navigator.pop(context);
              _editSound();
              const CustomFlushbar().showCustomFlushbar(
                  context: context,
                  duration: 2,
                  type: 'success',
                  title: AppLocalizations.of(context)!.success,
                  message:   AppLocalizations.of(context)!.note_added_success,
                  icon: CupertinoIcons.checkmark);
            },
            icon: const Icon(
              Icons.check,
              size: 28,
              color: CupertinoColors.white,
            ),
            title: AppLocalizations.of(context)!.edit_note,
          ),
          Expanded(child: _body()),
        ],
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          CustomTextField(
            cursorColor: Color(widget.noteModel.color),
            initialValue: widget.noteModel.title,
            onChanged: (value) {
              title = value;
            },
            hintText:   AppLocalizations.of(context)!.edit_title_hint,
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextField(
            cursorColor: Color(widget.noteModel.color),
            initialValue: widget.noteModel.subTitle,
            onChanged: (value) {
              subTitle = value;
            },
            hintText:   AppLocalizations.of(context)!.edit_content_hint,
            maxLines: 10,
          ),
          SizedBox(
            height: 16.h,
          ),
          EditColorsList(
            noteModel: widget.noteModel,
          ),
        ],
      ),
    );
  }
}
