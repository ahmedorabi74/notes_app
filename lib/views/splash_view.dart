import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notesss_app/views/ramadan_splash.dart';

import '../main.dart';
import '../service/finger_print_service.dart';
import 'notes_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final LocalAuthService _authService = LocalAuthService();
  bool _isAuthenticated = false; // Control UI rendering
  bool fingerPrintEnabled = sharedPref.getBool('fingerprint') ?? false;

  @override
  void initState() {
    super.initState();
    fingerPrintEnabled ? _authenticateOnStart() : null;
  }

  Future<void> _authenticateOnStart() async {
    bool isAuthenticated = await _authService.authenticate();

    if (!isAuthenticated) {
      Fluttertoast.showToast(
        msg: "Authentication Failed",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0.sp,
      );

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context); // Exit if authentication fails
      });
      return;
    }

    setState(() {
      _isAuthenticated = true; // Show the UI only after authentication
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAuthenticated && fingerPrintEnabled) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NotesView(),
        ),
      );
    });

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          children: [
            SizedBox(height: 120.h),
            animationPic(),
            SizedBox(height: 80.h),
            Text(
              AppLocalizations.of(context)!.developing_by,
              style: TextStyle(
                  fontSize: 24.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )
                .animate()
                .move(duration: 1500.milliseconds, begin: Offset(-100, 0)),
            SizedBox(
              height: 20.h,
            ),
            Text(
              AppLocalizations.of(context)!.ahmed_oraby,
              style: TextStyle(
                  fontFamily: 'PlaywriteIN',
                  fontSize: 18.sp,
                  color: const Color(0xff9EFFFF),
                  fontWeight: FontWeight.bold),
            )
                .animate()
                .move(duration: 1500.milliseconds, begin: Offset(100, 0))
                .fadeIn(),
          ],
        ),
      ),
    );
  }

  Widget animationPic() {
    return Column(
      children: [
        Container(
          height: 2.h,
          width: double.infinity,
          color: const Color(0xff9EFFFF),
        ).animate().scale(duration: 1.seconds, alignment: Alignment.centerLeft),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 2.w,
              height: 250.h,
              color: const Color(0xff9EFFFF),
            ).animate(delay: 1.seconds).scale(
                duration: 500.milliseconds, alignment: Alignment.bottomCenter),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50.h),
              child: Image.asset(
                "assets/images/appLogo.png",
                height: 200.h,
              ).animate().fadeIn(duration: 2.seconds),
            ),
            Container(
              width: 2.w,
              height: 250.h,
              color: const Color(0xff9EFFFF),
            ).animate(delay: 1.seconds).scale(
                duration: 500.milliseconds, alignment: Alignment.topCenter),
          ],
        ),
        Container(
          height: 2.h,
          width: double.infinity,
          color: const Color(0xff9EFFFF),
        )
            .animate()
            .scale(duration: 1.seconds, alignment: Alignment.centerRight),
      ],
    );
  }
}
