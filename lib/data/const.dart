import 'package:flutter/material.dart';

class AppColors {
  final LinearGradient kPrimaryGradientGreenColor = const LinearGradient(
    colors: [Color(0xff21b4f5), Color(0xff21b4f5)],
    stops: [0.25, 0.75],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  final LinearGradient kPrimaryGradientChartGreenColor = const LinearGradient(
    colors: [
      Color(0xff21b4f5),
      Color.fromARGB(255, 246, 255, 248),
    ],
    stops: [0.25, 0.75],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  final LinearGradient kPrimaryGradientOpacityColor = LinearGradient(
    colors: [
      const Color(0xff21b4f5).withOpacity(0.5),
      Color.fromARGB(255, 224, 255, 238).withOpacity(0.5)
    ],
    stops: const [0.25, 0.75],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  final Color kPrimaryBackgroundColor = const Color(0xFFF6F7FA);
  final Color kPrimaryDarkBackgroundColor =
      const Color.fromARGB(255, 21, 21, 21);
  final Color kPrimaryWhite = Colors.white;
  final Color kPrimaryGreen = const Color(0xff21b4f5);
  final Color kPrimaryBlue = const Color(0x0ffe07ff);
  final Color kPrimaryGrey = const Color(0xFFA0AEB9);
  final LinearGradient kPrimaryGradientGrey = const LinearGradient(
    colors: [Color(0xff9fadb9), Color(0xff9fadb9)],
    stops: [0.25, 0.75],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  final LinearGradient kPrimaryGradientWhite = const LinearGradient(
    colors: [Color(0xffffffff), Color(0xffffffff)],
    stops: [0.25, 0.75],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppData {
  static String baseUrl = 'https://back.btcpool.kz';
}
