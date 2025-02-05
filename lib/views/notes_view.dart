import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notesss_app/cubits/langage_cubit/langage_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubits/notes_cubit/notes_cubit.dart';
import '../main.dart';
import '../service/finger_print_service.dart';
import '../widgets/add_note_bottom_sheet.dart';
import '../widgets/notes_view_body.dart';
import 'info_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  bool isImportant = false;

  // getter from bool in shared pref
  bool fingerPrintEnabled = sharedPref.getBool('fingerprint') ?? false;

// setter from bool in shared pref
  static Future<void> setFingerPrintValue() async {
    bool currentValue = sharedPref.getBool('fingerprint') ?? false; // Get current value
    await sharedPref.setBool('fingerprint', !currentValue); // Toggle value
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      floatingActionButton: isImportant
          ? null
          : FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: const Color(0xff252525),
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  context: context,
                  builder: (context) {
                    return const AddNoteBottomSheet();
                  },
                );
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 48.h,
              ),
            ),
      body: NotesViewBody(isImportant: isImportant),
    );
  }

  Drawer drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: Text(
              AppLocalizations.of(context)!.app_title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 24.sp,
              ),
            ),
          ),
          listTileForDrawer(
            context: context,
            title: AppLocalizations.of(context)!.all_notes,
            onPressed: () {
              setState(() {
                isImportant = false;
              });
              BlocProvider.of<NotesCubit>(context).fetchAllNotes();
              Navigator.pop(context);
            },
            icon: FontAwesomeIcons.solidNoteSticky,
          ),
          listTileForDrawer(
            context: context,
            title: AppLocalizations.of(context)!.favourite_notes,
            onPressed: () {
              setState(() {
                isImportant = true;
              });
              BlocProvider.of<NotesCubit>(context).fetchFavouriteNotes();
              Navigator.pop(context);
            },
            icon: FontAwesomeIcons.solidStar,
          ),
          listTileForDrawer(
            context: context,
            title: AppLocalizations.of(context)!.language,
            onPressed: showToast,
            icon: Icons.language,
          ),
          listTileForDrawer(
            context: context,
            title: AppLocalizations.of(context)!.finger_print,
            onPressed: () {},
            icon: FontAwesomeIcons.fingerprint,
          ),
          listTileForDrawer(
            context: context,
            title: AppLocalizations.of(context)!.about_app,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InfoView()),
              );
            },
            icon: FontAwesomeIcons.info,
          ),
          listTileForDrawer(
            context: context,
            title: AppLocalizations.of(context)!.about_developer,
            onPressed: () async {
              final url = Uri.parse('https://ahmedoraby-portfolio.vercel.app/');
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            icon: CupertinoIcons.info,
          ),
        ],
      ),
    );
  }

  Widget listTileForDrawer({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    bool isFingerPrint = title == 'Finger Print' ||
        title == 'Fingerabdruck' ||
        title == 'بصمة الإصبع';

    return ListTile(
      leading: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.amber),
      ),
      title: Text(title),
      trailing: isFingerPrint
          ? Switch(
        value: fingerPrintEnabled,
        onChanged: (bool value) async {
          await setFingerPrintValue(); // Toggle value in SharedPreferences
          setState(() {
            fingerPrintEnabled = !fingerPrintEnabled; // Toggle UI state
          });
        },
        activeColor: Colors.amber,
      )
          : (title == 'Language' || title == 'Sprache' || title == 'اللغة'
              ? PopupMenuButton<String>(
                  onSelected: (value) {
                    BlocProvider.of<LangCubit>(context).changeLanga(value);
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      popupMenuItem(value: 'ar', text: 'عربي', flag: 'ar-eg'),
                      popupMenuItem(
                          value: 'en', text: 'English', flag: 'en-us'),
                      popupMenuItem(value: 'de', text: 'Deutsch', flag: 'de'),
                    ];
                  },
                  icon: const Icon(Icons.arrow_drop_down,
                      color: Colors.amber, size: 32),
                )
              : null),
      onTap: onPressed,
    );
  }

  void showToast() {
    Fluttertoast.showToast(
      msg: AppLocalizations.of(context)!.language_menu_hint,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      fontSize: 16.0.sp,
    );
  }

  PopupMenuItem<String> popupMenuItem({
    required String value,
    required String text,
    required String flag,
  }) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
          ),
          const Spacer(),
          CountryFlag.fromLanguageCode(
            height: 20.h,
            width: 30.w,
            flag,
          ),
        ],
      ),
    );
  }
}
