import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/notes_cubit/notes_cubit.dart';
import 'custom_appbar.dart';
import 'custom_flushbar.dart';
import 'note_item.dart';
import 'package:notesss_app/models/note_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotesViewBody extends StatefulWidget {
  const NotesViewBody({super.key, required this.isImportant});

  final bool isImportant;

  @override
  State<NotesViewBody> createState() => _NotesViewBodyState();
}

class _NotesViewBodyState extends State<NotesViewBody> {
  @override
  void initState() {
    BlocProvider.of<NotesCubit>(context).fetchAllNotes();
    super.initState();
  }

  bool isTextFieldVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 50.h,
          ),
          CustomAppBAr(
            isHome: true,
            onPressedDrawer: () {
              Scaffold.of(context).openDrawer();
            },
            onPressed: () {
              setState(() {
                isTextFieldVisible = !isTextFieldVisible;
                widget.isImportant
                    ? BlocProvider.of<NotesCubit>(context).fetchFavouriteNotes()
                    : BlocProvider.of<NotesCubit>(context).fetchAllNotes();
              });
            },
            title: widget.isImportant
                ? AppLocalizations.of(context)!.favourite_notes
                : AppLocalizations.of(context)!.all_notes,
            icon: const Icon(
              Icons.search,
              size: 28,
              color: CupertinoColors.white,
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
          customTextField(context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: BlocBuilder<NotesCubit, NotesState>(
                builder: (context, state) {
                  final notes =
                      BlocProvider.of<NotesCubit>(context).filteredData ?? [];
                  if (BlocProvider.of<NotesCubit>(context).notes!.length > 0 &&
                      notes.isEmpty &&
                      isTextFieldVisible == true) {
                    // Display message and image and image if no notes
                    return noNotesInSearch();
                  } else if (notes.isEmpty) {
                    // Display message and image and image if no notes
                    return noNotesView(
                        isNormalNotes:
                            context.read<NotesCubit>().notes?.isNotEmpty ??
                                false);
                  } else {
                    // Display list of notes
                    return notesList(notes);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customTextField(BuildContext context) {
    return Visibility(
      visible: isTextFieldVisible,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        // Horizontal padding
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(10.r), // Rounded corners
        ),
        child: TextField(
          style: TextStyle(
            fontSize: 16.sp, // Set text size (scaled)
            color:
                CupertinoColors.black, // Set text color (change this as needed)
          ),
          onChanged: (value) {
            context
                .read<NotesCubit>()
                .filterData(typedText: value, isImportant: widget.isImportant);
          },
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.search_hint,
            hintStyle:
                TextStyle(fontSize: 14.sp, color: CupertinoColors.systemGrey),
            border: InputBorder.none, // Removes the default border
            contentPadding: EdgeInsets.symmetric(
                vertical: 12.h), // Vertical padding for content
          ),
        ),
      ),
    );
  }

//**********************//
  Widget notesList(List<NoteModel> notes) {
    return ListView.builder(
      itemCount: notes.length,
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: NoteItem(
              noteModel: notes[index],
            )
                .animate()
                .flip(duration: 1.seconds)
                .scale(duration: 500.milliseconds));
      },
    );
  }

//**********************//
  Widget noNotesView({required bool isNormalNotes}) {
    print('🍉🍉🍉🍉$isNormalNotes');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/rafiki.png',
          height: 290.h,
          width: 350.w,
        ),
        SizedBox(height: 20.h),
        Text(
          isNormalNotes
              ? AppLocalizations.of(context)!.favourite_notes
              : AppLocalizations.of(context)!.create_ur_first_note,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.sp,
            color: CupertinoColors.white,
          ),
        ),
      ],
    );
  } //**********************//

  Widget noNotesInSearch() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/cuate.png',
          height: 290.h,
          width: 350.w,
        ),
        SizedBox(height: 20.h),
        Text(
          textAlign: TextAlign.center,
          AppLocalizations.of(context)!.note_not_found,
          style: TextStyle(
            fontSize: 20.sp,
            color: CupertinoColors.white,
          ),
        ),
      ],
    );
  }
}
