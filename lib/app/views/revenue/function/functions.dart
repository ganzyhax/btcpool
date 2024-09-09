import 'package:easy_localization/easy_localization.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RevenueFunctions {
  Future<List> selectDateRange(BuildContext context) async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
      initialDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 7)),
      ),
      builder: (context, child) {
        return Theme(
          data: (Theme.of(context).colorScheme.brightness == Brightness.dark)
              ? ThemeData.dark().copyWith(
                  colorScheme: ColorScheme.dark(
                    primary:
                        AppColors().kPrimaryGreen, // Theme color for the picker
                  ),
                )
              : ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary:
                        AppColors().kPrimaryGreen, // Theme color for the picker
                  ),
                ),
          child: child!,
        );
      },
    );

    if (newDateRange != null) {
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

    DateFormat formatter = DateFormat(
      'dd MMM, yyyy',
    );
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  String getFormattedDateMinusTenDays() {
    DateTime now = DateTime.now().subtract(const Duration(days: 10));

    DateFormat formatter = DateFormat('dd MMM, yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  List convertResultDate(List data) {
    List res = [];

    for (var i = 0; i < 2; i++) {
      String inputDate = data[i];

      DateTime date = DateFormat('dd MMM, yyyy').parse(inputDate);

      String formattedDate = DateFormat('yyyy-MM-dd').format(date);

      res.add(formattedDate);
    }
    return res;
  }
}
