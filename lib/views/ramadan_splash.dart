import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'notes_view.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RamdanView extends StatefulWidget {
  const RamdanView({super.key});

  @override
  State<RamdanView> createState() => _RamdanViewState();
}

class _RamdanViewState extends State<RamdanView> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NotesView(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 120.h),
              Image.asset(
                "assets/images/ramadan splash.png",
                height: 300.h,
              )
                  .animate()
                  .scale(
                    duration: 1.seconds,
                  )
                  .move(begin: Offset(0, -200))
                  .flip(),
              SizedBox(height: 80.h),
              Text(
                AppLocalizations.of(context)!.ramadan,
                style: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
                  .animate()
                  .move(duration: 1.seconds, begin: Offset(-100, 0))
                  .shimmer(color: Colors.amber),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
