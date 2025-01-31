sealed class LangState {}

final class LangInitial extends LangState {}

class LangLoaded extends LangState {}

class SuccessChanged extends LangState {
  final String lan;

  SuccessChanged(this.lan);
}

class LangAR extends LangState {}

class LangEN extends LangState {}

class LangDE extends LangState {}
