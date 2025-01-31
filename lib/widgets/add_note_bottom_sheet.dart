import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:notesss_app/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notesss_app/cubits/add_note_cubit/add_note_state.dart';

import 'package:notesss_app/widgets/custom_flushbar.dart';

import '../cubits/notes_cubit/notes_cubit.dart';
import 'add_note_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddNoteBottomSheet extends StatelessWidget {
  const AddNoteBottomSheet({super.key});

  void _playSoundAddNote() async {
    final audioPlayer = AudioPlayer(); // Create a local instance
    await audioPlayer.play(AssetSource('sounds/addNoteSuccess.mp3'));
    await Future.delayed(const Duration(seconds: 2)); // Simulate Sound time
    audioPlayer.dispose(); // Dispose after use
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNoteCubit(),
      child: BlocConsumer<AddNoteCubit, AddNoteState>(
        listener: (context, state) {
          if (state is AddNoteFailure) {
            const CustomFlushbar().showCustomFlushbar(
                context: context,
                duration: 3,
                type: 'error',
                title: 'error',
                message: AppLocalizations.of(context)!.error_message,
                icon: Icons.error);
          }
          if (state is AddNoteSuccess) {
            _playSoundAddNote();
            BlocProvider.of<NotesCubit>(context).fetchAllNotes();
            Navigator.pop(context);

            const CustomFlushbar().showCustomFlushbar(
                context: context,
                duration: 2,
                type: 'success',
                title: AppLocalizations.of(context)!.success,
                message: AppLocalizations.of(context)!.note_added_success,
                icon: CupertinoIcons.checkmark);
          }
        },
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state is AddNoteLoading ? true : false,
            // AbsorbPointer disable all actions until loading finish like modalPrograsHud
            child: Padding(
              padding: EdgeInsets.only(
                  right: 16,
                  left: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: const SingleChildScrollView(child: AddNoteForm()),
            ),
          );
        },
      ),
    );
  }
}
