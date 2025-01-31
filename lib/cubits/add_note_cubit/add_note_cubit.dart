import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notesss_app/constans.dart';
import 'package:notesss_app/cubits/add_note_cubit/add_note_state.dart';



import 'package:notesss_app/models/note_model.dart';









class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(AddNoteInitial());
  Color? color = const Color(0xFFFD99FF); // Light Blue is default value for the note;

  addNote(NoteModel note) async {
    note.color = color!.value;
    emit(AddNoteLoading());
    try {
      var notesBox = Hive.box(kNotesBox);
      await notesBox.add(note);
      emit(AddNoteSuccess());
    } on Exception catch (e) {
      emit(AddNoteFailure(errorMessage: e.toString()));
    }
  }
}
