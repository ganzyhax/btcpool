import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RevenueFunctions {
  Future<List> selectDateRange(BuildContext context) async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(Duration(days: 7)),
      ),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors().kPrimaryGreen, // Theme color for the picker
            ),
          ),
          child: child!,
        );
      },
    );

    if (newDateRange != null) {
      print("Range selected: ${newDateRange.start} to ${newDateRange.end}");
      return [newDateRange.start, newDateRange.end];
    } else {
      String todayDate = getTodayDateFormatted();
      return [todayDate, todayDate];
    }
  }

  List formatPickedDates(List inputDate) {
    List res = [];
    if (!inputDate[0].toString().contains(',')) {
      for (var i = 0; i < 2; i++) {
        DateTime date = DateTime.parse(inputDate[i].toString());
        DateFormat formatter = DateFormat('dd MMM, yyyy');
        String formattedDate = formatter.format(date);
        res.add(formattedDate);
      }
    } else {
      res = inputDate;
    }
    return res;
  }

  String getTodayDateFormatted() {
    DateTime now = DateTime.now();

    // Создаем объект DateFormat для требуемого формата даты
    DateFormat formatter = DateFormat('dd MMM, yyyy');
    // Форматируем дату с использованием DateFormat
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  List convertResultDate(List data) {
    List res = [];

    for (var i = 0; i < 2; i++) {
      String inputDate = data[i];

      // Парсинг строки в формат даты
      DateTime date = DateFormat('dd MMM, yyyy').parse(inputDate);

      // Форматирование даты в требуемый формат
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);

      print(formattedDate);
      res.add(formattedDate);
    }
    return res;
  }
}
