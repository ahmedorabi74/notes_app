sealed class DeleteNoteState {}

final class DeleteNoteInitial extends DeleteNoteState {}

final class DeleteNoteInProgress extends DeleteNoteState {}

final class SuccessDelete extends DeleteNoteState {}
