import 'package:bloc/bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../constLan.dart';

import '../../main.dart';
import 'langage_state.dart';

class LangCubit extends Cubit<LangState> {
  LangCubit() : super(LangInitial());

  void changeLanga(String language) async {
    emit(LangLoaded());
    await sharedPref.setString('Language', language);
    emit(SuccessChanged(language));
  }
}
