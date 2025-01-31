part of 'notes_cubit.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}

class NotesSuccess extends NotesState {}class NotesSuccessD extends NotesState {}

class NotesSuccessSearch extends NotesState {
  NotesSuccessSearch();
}

class NoteFailureSearch extends NotesState {}
// class NotesSuccessTextField extends NotesState {
//   final bool isTextFieldVisible;
//
//   NotesSuccessTextField({required this.isTextFieldVisible});
// }