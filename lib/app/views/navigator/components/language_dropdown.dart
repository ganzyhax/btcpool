import 'dart:developer';

import 'package:btcpool_app/api/api_utils.dart';
import 'package:btcpool_app/api/local_auth.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LanguageDropdown extends StatefulWidget {
  @override
  _LanguageDropdownState createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String _selectedLanguage = 'RU'; // Default selected value

  final List<Map<String, String>> _languages = [
    {'code': 'kk', 'name': 'Қазақша', 'icon': 'assets/icons/kz_flag.png'},
    {'code': 'ru', 'name': 'Русский', 'icon': 'assets/icons/ru_flag.png'},
  ];
  @override
  void initState() {
    // TODO: implement initState
    initFunc();
    super.initState();
  }

  Future<void> initFunc() async {
    String localLang = await AuthUtils.getLanguage();
    if (localLang != 'null') {
      _selectedLanguage = localLang.toUpperCase();
    } else {
      _selectedLanguage = Intl.getCurrentLocale().toUpperCase();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 30,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              icon: Icon(Icons.language, color: Colors.black),
              style: TextStyle(color: Colors.black),
              underline: SizedBox.shrink(), // Removes the underline

              onChanged: (String? value) async {
                log(value.toString());
                setState(() {
                  _selectedLanguage = value!;
                });
                await AuthUtils.setLanguage(value.toString().toLowerCase());
                context.setLocale(Locale(value.toString().toLowerCase()));
              },
              menuWidth: 140,

              padding: EdgeInsets.all(0),
              items: _languages.map<DropdownMenuItem<String>>((lang) {
                return DropdownMenuItem<String>(
                  value: lang['code']!.toUpperCase(),
                  child: Row(
                    children: [
                      Image.asset(
                        lang['icon']!,
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 8),
                      Text(lang['name']!),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          _selectedLanguage,
          style: TextStyle(fontSize: 19),
        )
      ],
    );
  }
}
