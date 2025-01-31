import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';

import 'package:notesss_app/models/note_model.dart';

import '../../constans.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());
  List<NoteModel>? notes;
  List<NoteModel>? favNotes;
  List<NoteModel>? filteredData;
  bool isTextFieldVisible = false;

  fetchAllNotes() {
    var notesBox = Hive.box<dynamic>(kNotesBox); // Open as dynamic
    notes = notesBox.values
        .map((note) => note as NoteModel) // Cast entries to NoteModel
        .toList();
    filteredData = notes;
    emit(NotesSuccess());
  }

  fetchFavouriteNotes() {
    var notesBox = Hive.box<dynamic>(kNotesBox); // Open as dynamic
    favNotes = notesBox.values
        .map((note) => note as NoteModel) // Cast entries to NoteModel
        .where(
            (note) => note.isImportant == true) // Filter based on isImportant
        .toList();

    filteredData = favNotes;
    emit(NotesSuccess());
  }

  void filterData({
    required String typedText,
    required bool isImportant,
  }) {
    try {
      if (typedText.isEmpty) {
        // Show all items or favorite notes if the search text is empty
        filteredData = isImportant ? favNotes ?? [] : notes ?? [];
      } else {
        // Ensure source list is not null before filtering
        filteredData = (isImportant ? favNotes ?? [] : notes ?? [])
            .where((data) =>
            data.title.toLowerCase().contains(typedText.toLowerCase()))
            .toList();
      }

      emit(NotesSuccessSearch()); // Emit success state
    } catch (e) {
      emit(NoteFailureSearch());
    }
  }

}
