import 'dart:developer';

import 'package:btcpool_app/api/api_utils.dart';
import 'package:home_widget/home_widget.dart';

class HomeWidgetController {
  void updateAllData(data) {
    HomeWidget.saveWidgetData("account_data", data['subAccount'].toString());
    HomeWidget.saveWidgetData("hashrate_data", data['hashrate'].toString());
    HomeWidget.saveWidgetData("online_data", data['online'].toString());
    HomeWidget.saveWidgetData("offline_data", data['offline'].toString());
    HomeWidget.saveWidgetData("dead_data", data['dead'].toString());
    HomeWidget.saveWidgetData("btc_data", data['btc'].toString());
    HomeWidget.saveWidgetData("balance_data", data['balance'].toString());
    log("balance_data " + data['balance'].toString());
    HomeWidget.updateWidget(
      androidName: "QuoteWidget",
    );
  }

  void updateThemeMode(bool isDark) {
    if (isDark) {
      HomeWidget.saveWidgetData("dark", 'true');
    } else {
      HomeWidget.saveWidgetData("dark", 'false');
    }

    HomeWidget.updateWidget(
      androidName: "QuoteWidget",
    );
  }

  void init() async {
    final isDark = await AuthUtils.getThemeMode();
    if (isDark) {
      HomeWidget.saveWidgetData("dark", 'true');
    } else {
      HomeWidget.saveWidgetData("dark", 'false');
    }
    final isUserHave = await AuthUtils.getUserId();
    if (isUserHave.toString() == 'null' || isUserHave.toString() == '') {
      String language = await AuthUtils.getLanguage();
      if (language == 'null') {
        HomeWidget.saveWidgetData("hashrate_title", 'Hashrate');
        HomeWidget.saveWidgetData("btc_title", 'BTC');
        HomeWidget.saveWidgetData("balance_title", 'Balance');
        HomeWidget.saveWidgetData("online_title", 'Online:');
        HomeWidget.saveWidgetData("offline_title", 'Offline:');
        HomeWidget.saveWidgetData("dead_title", 'Dead:');

        HomeWidget.saveWidgetData("account_data", 'You are not logged in!!');
        HomeWidget.saveWidgetData("hashrate_data", '-');
        HomeWidget.saveWidgetData("btc_data", '-');
        HomeWidget.saveWidgetData("balance_data", '-');
        HomeWidget.saveWidgetData("online_data", '-');
        HomeWidget.saveWidgetData("offline_data", '-');
        HomeWidget.saveWidgetData("dead_data", '-');
      }
      if (language.contains('ru')) {
        HomeWidget.saveWidgetData("hashrate_title", 'Хэшрейт');
        HomeWidget.saveWidgetData("btc_title", 'BTC');
        HomeWidget.saveWidgetData("online_title", 'Онлайн:');
        HomeWidget.saveWidgetData("offline_title", 'Оффлайн:');
        HomeWidget.saveWidgetData("dead_title", 'Неактивные:');
        HomeWidget.saveWidgetData("balance_title", 'Баланс:');

        HomeWidget.saveWidgetData("account_data", 'Вы не вошли в систему!!');
        HomeWidget.saveWidgetData("hashrate_data", '-');
        HomeWidget.saveWidgetData("btc_data", '-');
        HomeWidget.saveWidgetData("online_data", '-');
        HomeWidget.saveWidgetData("offline_data", '-');
        HomeWidget.saveWidgetData("dead_data", '-');
        HomeWidget.saveWidgetData("balance_data", '-');
      }
      if (language.contains('pt')) {
        HomeWidget.saveWidgetData("hashrate_title", 'Taxa de Hash');
        HomeWidget.saveWidgetData("btc_title", 'BTC');
        HomeWidget.saveWidgetData("online_title", 'Online:');
        HomeWidget.saveWidgetData("offline_title", 'Offline:');
        HomeWidget.saveWidgetData("dead_title", 'Inativo:');
        HomeWidget.saveWidgetData("balance_title", 'Saldo:');

        HomeWidget.saveWidgetData("account_data", 'Você não está logado!!');
        HomeWidget.saveWidgetData("hashrate_data", '-');
        HomeWidget.saveWidgetData("btc_data", '-');
        HomeWidget.saveWidgetData("online_data", '-');
        HomeWidget.saveWidgetData("offline_data", '-');
        HomeWidget.saveWidgetData("dead_data", '-');
        HomeWidget.saveWidgetData("balance_data", '-');
      }
      if (language.contains('es')) {
        HomeWidget.saveWidgetData("hashrate_title", 'Tasa de Hash');
        HomeWidget.saveWidgetData("btc_title", 'BTC');
        HomeWidget.saveWidgetData("online_title", 'En línea:');
        HomeWidget.saveWidgetData("offline_title", 'Fuera de línea:');
        HomeWidget.saveWidgetData("dead_title", 'Inactivo:');
        HomeWidget.saveWidgetData("balance_title", 'Saldo:');

        HomeWidget.saveWidgetData("account_data", '¡No has iniciado sesión!');
        HomeWidget.saveWidgetData("hashrate_data", '-');
        HomeWidget.saveWidgetData("btc_data", '-');
        HomeWidget.saveWidgetData("online_data", '-');
        HomeWidget.saveWidgetData("offline_data", '-');
        HomeWidget.saveWidgetData("dead_data", '-');
        HomeWidget.saveWidgetData("balance_data", '-');
      }
      if (language.contains('ar')) {
        HomeWidget.saveWidgetData("hashrate_title", 'سرعة التجزئة');
        HomeWidget.saveWidgetData("btc_title", 'بتكوين');
        HomeWidget.saveWidgetData("online_title", 'متصل:');
        HomeWidget.saveWidgetData("offline_title", 'غير متصل:');
        HomeWidget.saveWidgetData("dead_title", 'غير فعال:');

        HomeWidget.saveWidgetData("account_data", 'لم تقم بتسجيل الدخول!');
        HomeWidget.saveWidgetData("hashrate_data", '-');
        HomeWidget.saveWidgetData("btc_data", '-');
        HomeWidget.saveWidgetData("online_data", '-');
        HomeWidget.saveWidgetData("offline_data", '-');
        HomeWidget.saveWidgetData("dead_data", '-');
      }

      if (language.contains('en')) {
        HomeWidget.saveWidgetData("hashrate_title", 'Hashrate');
        HomeWidget.saveWidgetData("btc_title", 'BTC');
        HomeWidget.saveWidgetData("online_title", 'Online:');
        HomeWidget.saveWidgetData("offline_title", 'Offline:');
        HomeWidget.saveWidgetData("dead_title", 'Dead:');
        HomeWidget.saveWidgetData("balance_title", 'Balance');

        HomeWidget.saveWidgetData("account_data", 'You are not logged in!!');
        HomeWidget.saveWidgetData("hashrate_data", '-');
        HomeWidget.saveWidgetData("btc_data", '-');
        HomeWidget.saveWidgetData("online_data", '-');
        HomeWidget.saveWidgetData("offline_data", '-');
        HomeWidget.saveWidgetData("dead_data", '-');
        HomeWidget.saveWidgetData("balance_data", '-');
      }
      HomeWidget.updateWidget(
        androidName: "QuoteWidget",
      );
    }
  }
}
