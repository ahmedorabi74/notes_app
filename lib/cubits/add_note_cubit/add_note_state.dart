
sealed class AddNoteState {}

final class AddNoteInitial extends AddNoteState {}

final class AddNoteLoading extends AddNoteState {}

class AddNoteSuccess extends AddNoteState {}

final class AddNoteFailure extends AddNoteState {
  final String errorMessage;

  AddNoteFailure({required this.errorMessage});
}
