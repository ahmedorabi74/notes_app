import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'notes_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
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
            SizedBox(height:  120.h),
            animationPic(),
            SizedBox(height:  80.h),
            Text(
             AppLocalizations.of(context)!.developing_by,
              style: TextStyle(
                  fontSize: 24.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ).animate().move(duration: 1500.milliseconds, begin: Offset(-100, 0)),
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
              child:Image.asset(
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
