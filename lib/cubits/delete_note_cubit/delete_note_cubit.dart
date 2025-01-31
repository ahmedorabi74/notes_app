import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notesss_app/cubits/delete_note_cubit/delete_note_state.dart';
import 'package:notesss_app/models/note_model.dart';



class DeleteNoteCubit extends Cubit<DeleteNoteState> {
  DeleteNoteCubit() : super(DeleteNoteInitial());

  Future<void> deleteNote(NoteModel note) async {
    emit(DeleteNoteInProgress());
    await Future.delayed(const Duration(seconds: 0)); // Simulate animation time
    note.delete(); // Perform the deletion
    emit(SuccessDelete()); // Notify success
  }
}
