import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'custom_search_icon.dart';

class CustomAppBAr extends StatelessWidget {
  const CustomAppBAr(
      {super.key,
      required this.title,

      required this.icon,
      this.onPressed,
      this.shimmerColor = const Color(0xFF80DDFF),
      this.onPressedDrawer, required this.isHome});

  final Icon icon;
  final String title;
  final bool isHome;
  final void Function()? onPressed;
  final void Function()? onPressedDrawer;
  final Color? shimmerColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (isHome == true)
          GestureDetector(
            onTap: onPressedDrawer,
            child: const CustomIcon(
              icon: Icon(Icons.menu),
            ),
          ),
        Text(
          title,
          style: const TextStyle(fontSize: 28),
        ).animate().shimmer(
              duration: 1500.milliseconds,
              color: shimmerColor,
            ),
        GestureDetector(
          onTap: onPressed,
          child: CustomIcon(
            icon: icon,
          ),
        ),
      ],
    );
  }
}
