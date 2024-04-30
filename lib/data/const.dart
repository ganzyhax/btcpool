import 'package:flutter/material.dart';

class AppColors {
  final LinearGradient kPrimaryGradientGreenColor = LinearGradient(
    colors: [
      Color.fromARGB(255, 57, 130, 240),
      Color.fromARGB(255, 57, 130, 240)
    ],
    stops: [0.25, 0.75],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  final LinearGradient kPrimaryGradientOpacityColor = LinearGradient(
    colors: [
      Color(0xff21b4f5).withOpacity(0.5),
      Color(0xff27cf74).withOpacity(0.5)
    ],
    stops: [0.25, 0.75],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  final Color kPrimaryBackgroundColor = Color(0xFFF6F7FA);
  final Color kPrimaryWhite = Colors.white;
  final Color kPrimaryGreen = Color.fromARGB(255, 57, 130, 240);
  final Color kPrimaryBlue = Color(0xFFE07FF);
  final Color kPrimaryGrey = Color(0xFFA0AEB9);
  final LinearGradient kPrimaryGradientGrey = LinearGradient(
    colors: [Color(0xff9fadb9), Color(0xff9fadb9)],
    stops: [0.25, 0.75],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  final LinearGradient kPrimaryGradientWhite = LinearGradient(
    colors: [Color(0xffffffff), Color(0xffffffff)],
    stops: [0.25, 0.75],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppData {
  final String baseUrl = 'https://back.21pool.io';
}
