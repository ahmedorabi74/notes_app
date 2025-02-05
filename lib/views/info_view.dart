import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InfoView extends StatelessWidget {
  const InfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          AppLocalizations.of(context)!.about,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Center(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                  ),
                  child: Column(
                    spacing: 20.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      row(
                          urlLink: 'https://ahmedoraby-portfolio.vercel.app/',
                          fontSize: 24.sp,
                          imageSize: 50.h,
                          image: 'assets/images/logoSplash.png',
                          title: AppLocalizations.of(context)!.app_title,
                          isCenter: true),
                      Text(
                        AppLocalizations.of(context)!.about,
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      customText(
                        AppLocalizations.of(context)!.storage_info,
                      ),
                      customText(
                        AppLocalizations.of(context)!.internet_info,
                      ),
                      customText(
                        AppLocalizations.of(context)!.platform_info,
                      ),
                      customText(
                        AppLocalizations.of(context)!.version_info,
                      ),
                      Text(
                        AppLocalizations.of(context)!.social_media,
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      row(
                        urlLink:
                            'https://www.linkedin.com/in/ahmedoraby74?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app',
                        fontSize: 16.sp,
                        imageSize: 25.h,
                        image: 'assets/images/linkedLogo.png',
                        title: AppLocalizations.of(context)!.linkedin,
                      ),
                      row(
                        urlLink: 'https://ahmedoraby-portfolio.vercel.app/',
                        fontSize: 16.sp,
                        imageSize: 25.h,
                        image: 'assets/images/portfolio.png',
                        title: AppLocalizations.of(context)!.portfolio,
                      ),
                      Text(
                        AppLocalizations.of(context)!.help_center,
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      customText(
                        AppLocalizations.of(context)!.bug_feature_request,
                      ),
                      row(
                        urlLink: 'https://Wa.me/201202934495',
                        fontSize: 16.sp,
                        imageSize: 25.h,
                        image: 'assets/images/whatsapp.png',
                        title: AppLocalizations.of(context)!.whatsapp,
                      ),
                      row(
                        urlLink: 'mailto:ahmedoraby046@gmail.com',
                        fontSize: 16.sp,
                        imageSize: 25.h,
                        image: 'assets/images/gmail.png',
                        title: AppLocalizations.of(context)!.gmail,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

// Inside your InfoView class
//   void _openGmail() async {
//     final Uri emailUri = Uri.parse("mailto:ahmedoraby046@gmail.com");
//     // Opens Gmail if installed
//     if (await launchUrl(emailUri)) {
//       await launchUrl(emailUri);
//     } else {
//       print('🍉🍉🍉');
//       await launchUrl(Uri.parse("https://mail.google.com"));
//     }
//   }

  Widget row({
    required String image,
    required String title,
    bool isCenter = false,
    required double imageSize,
    required double fontSize,
    String? urlLink,
  }) {
    return GestureDetector(
      onTap: isCenter
          ? () {}
          : () async {
              // _openGmail();
              if (urlLink != null) {
                final Uri url = Uri.parse(urlLink);
                if (urlLink.startsWith('mailto:')) {
                  // Handle email links
                  if (await launchUrl(url)) {
                    await launchUrl(url);
                  } else {
                     throw 'Could not launch $url';
                  }
                } else {
                  // Handle other URLs
                  if (await launchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }
              }
            },
      child: Row(
        spacing: 15.w,
        mainAxisAlignment:
            isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Image.asset(
            image,
            height: imageSize.h,
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: fontSize.sp,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget customText(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600),
    );
  }
}
