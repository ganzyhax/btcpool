import 'package:flutter/material.dart';
import 'package:btcpool_app/local_data/const.dart';

ThemeData lightMode = ThemeData(
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
    primaryColor: AppColors().kPrimaryGreen,
    dividerColor: AppColors().kPrimaryGreen,
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        background: AppColors().kPrimaryBackgroundColor,
        secondary: Colors.white));

ThemeData darkMode = ThemeData(
    // colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
    useMaterial3: true,
    primaryColor: AppColors().kPrimaryGreen,
    dividerColor: AppColors().kPrimaryGreen,
    brightness: Brightness.dark,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
    colorScheme: ColorScheme.dark(
        background: AppColors().kPrimaryDarkBackgroundColor,
        secondary: Colors.black));
