import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notesss_app/constLan.dart';
import 'package:notesss_app/cubits/langage_cubit/langage_cubit.dart';
import 'package:notesss_app/cubits/langage_cubit/langage_state.dart';

import 'package:notesss_app/simple_bloc_observer.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil package
import 'package:notesss_app/views/splash_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constans.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'cubits/notes_cubit/notes_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'models/note_model.g.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();

  Bloc.observer =
      SimpleBlocObserver(); // Follow your bloc states with an easy way instead of print
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox(kNotesBox);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]); // Lock to portrait mode
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(400, 900),
      // Set the design size (width x height)
      minTextAdapt: true,
      // Ensures text scales properly
      splitScreenMode: true,
      // Handles split-screen mode (for foldables and multitasking)
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => NotesCubit(),
            ),
            BlocProvider(
              create: (context) => LangCubit(),
            ),
          ],
          child: BlocBuilder<LangCubit, LangState>(
            builder: (context, state) {
              Locale locale;
              // if (state is SuccessChanged) {
              //   locale = Locale(state.lan);
              // } else {
              //   locale = Locale(sharedPref.getString('Language') ?? 'en');
              //   // Default to English
              // }
              return MaterialApp(
                theme: ThemeData(
                    brightness: Brightness.dark, fontFamily: 'Poppins'),
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                debugShowCheckedModeBanner: false,
                locale: Locale(sharedPref.getString('Language') ?? 'en'),
                supportedLocales: const [
                  Locale('en'),
                  Locale('ar'),
                  Locale('de'),
                ],
                home: const Scaffold(
                  body: SplashView(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
