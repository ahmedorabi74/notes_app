import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notesss_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:notesss_app/models/note_model.dart';
import 'package:notesss_app/views/edit_note_view.dart';
import '../main.dart';
import '../views/view_full_note_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoteItem extends StatefulWidget {
  const NoteItem({super.key, required this.noteModel,  required this.onDelete});

  final NoteModel noteModel;

  final VoidCallback onDelete;

  @override
  State<NoteItem> createState() => _NoteItemState();
}

bool isDeleted = false;

void _deleteSound() async {
  final audioPlayer = AudioPlayer(); // Create a local instance
  await audioPlayer.play(AssetSource('sounds/deleteEffect.mp3'));
  await Future.delayed(const Duration(seconds: 2)); // Simulate Sound time
  audioPlayer.dispose(); // Dispose after use
}

class _NoteItemState extends State<NoteItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showChooseDialog(context, widget.noteModel);
      },
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ViewFullNoteView(
            noteModel: widget.noteModel,
          );
          // return EditNoteView(noteModel: widget.noteModel);
        }));
      },
      child: Container(
        padding: const EdgeInsets.only(top: 24, bottom: 24, left: 0),
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.red,width: 2),
          color: Color(widget.noteModel.color),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListTile(
              leading: IconButton(
                onPressed: () {
                  setState(() {
                    widget.noteModel.isImportant =
                        !widget.noteModel.isImportant;
                    widget.noteModel.save();
                  });
                },
                icon: Icon(
                  widget.noteModel.isImportant
                      ? FontAwesomeIcons.solidStar
                      : FontAwesomeIcons.star,
                  color: Colors.black,
                  size: 24,
                ),
              ),
              title: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                widget.noteModel.title,
                style: const TextStyle(color: Colors.black, fontSize: 26),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  widget.noteModel.subTitle,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 18.sp,
                  ),
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  showDeleteDialog(context, widget.noteModel);
                },
                icon: const Icon(
                  FontAwesomeIcons.trash,
                  color: Colors.black,
                  size: 24,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: sharedPref.getString('language') == 'ar' ? 24.w : 0.0,
                // Right padding for Arabic
                end: sharedPref.getString('language') == 'ar' ? 0.0 : 24.w,
                // Left padding for English
                top: 16.h,
              ),
              child: Text(
                '${widget.noteModel.date.split(" ")[0]} / ${formatTimeTo12HourAndSplit(widget.noteModel.date)}',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            )
          ],
        ),
      )
          .animate(
            target: isDeleted ? 1 : 0,
          )
          .move(
            begin: Offset.zero, // Start from the current position
            end: const Offset(-500, 0), // Move to the right, off-screen
            curve: Curves.easeInOut, // Smooth animation curve
            duration: 1.seconds,
          ),
    );
  }

  void showDeleteDialog(BuildContext parentContext, NoteModel note) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.confirm_delete,
          ),
          content: Text(
            AppLocalizations.of(context)!.delete_confirmation,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                AppLocalizations.of(context)!.cancel,
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                _deleteSound();

                setState(() {
                  isDeleted = true;
                });

                await Future.delayed(const Duration(seconds: 1)); // Simulate animation time
                note.delete();

                setState(() {
                  isDeleted = false;
                });

                // Call the callback function to remove the note from the list
                widget.onDelete();
              },
              child: Text(
                AppLocalizations.of(context)!.delete,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  //****************//
  void showChooseDialog(BuildContext context, NoteModel note) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0.r), // Rounded corners
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!.choose_action,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: Icon(Icons.edit, color: Colors.blue),
                  title: Text(
                    AppLocalizations.of(context)!.add,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return EditNoteView(noteModel: widget.noteModel);
                        },
                      ),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.delete, color: Colors.red),
                  title: Text(
                    AppLocalizations.of(context)!.delete,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    showDeleteDialog(context, widget.noteModel);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ****************//
  String formatTimeTo12HourAndSplit(String dateTime) {
    String time24 = dateTime.split(" ")[1].split(":").sublist(0, 2).join(":");
    DateTime time = DateFormat("HH:mm")
        .parse(time24); // Convert time string into DateTime to format into 12H
    return DateFormat("hh:mm a").format(time);
  }
}
