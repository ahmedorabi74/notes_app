import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CustomFlushbar extends StatelessWidget {
  const CustomFlushbar({Key? key}) : super(key: key);

  void showCustomFlushbar({
    required BuildContext context,
    required String title,
    required String message,
    int duration = 3,
    required IconData icon,
    String type = 'info', // Default type
  }) {
    // Choose colors based on the type
    List<Color> colors;
    switch (type) {
      case 'success':
        colors = [Colors.green, Colors.greenAccent, Colors.greenAccent,];
        break;
      case 'error':
        colors = [Colors.red, Colors.orange];
        break;
      case 'warning':
        colors = [Colors.yellow, Colors.orange];
        break;
      default:
        colors = [Colors.blue, Colors.teal]; // Default to info
    }

    Flushbar(
      animationDuration: Duration(seconds: 2),
      title: title,
      message: message,
      duration: Duration(seconds: duration),
      backgroundGradient: LinearGradient(
        colors: colors,
      ),
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      titleColor: Colors.white,
      messageColor: Colors.white,
      icon: Icon(icon, color: Colors.white),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
