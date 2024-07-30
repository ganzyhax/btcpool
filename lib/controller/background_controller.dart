import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:btcpool_app/api/api.dart';
import 'package:btcpool_app/api/api_utils.dart';
import 'package:btcpool_app/app/screens/dashboard/functions/functions.dart';
import 'package:btcpool_app/controller/home_widget_controller.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class BackgroundService {
  String notificationChannelId = 'my_foreground';

  int notificationId = 888;
  @pragma('vm:entry-point')
  Future<bool> onIosBackground(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();

    return true;
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    // Only available for flutter 3.0.0 and later
    DartPluginRegistrant.ensureInitialized();

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });

      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }

    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    // bring to foreground
    Timer.periodic(const Duration(seconds: 120), (timer) async {
      if (service is AndroidServiceInstance) {
        if (await service.isForegroundService()) {
          /// OPTIONAL for use custom notification
          /// the notification id must be equals with AndroidConfiguration when you call configure() method.
          // flutterLocalNotificationsPlugin.show(
          //   888,
          //   '21 Pool Service',
          //   'Awesome ${DateTime.now()}',
          //   const NotificationDetails(
          //     android: AndroidNotificationDetails(
          //       'my_foreground',
          //       'MY FOREGROUND SERVICE',
          //       icon: 'ic_bg_service_small',
          //       ongoing: true,
          //     ),
          //   ),
          // );

          // // if you don't using custom notification, uncomment this
          // service.setForegroundNotificationInfo(
          //   title: "My App Service",
          //   content: "Updated at ${DateTime.now()}",
          // );
        }
      }

      var data = await getAllData();

      HomeWidgetController().updateAllData(data);
    });
  }

  void initializeService() async {
    final service = FlutterBackgroundService();

    /// OPTIONAL, using custom notification channel id
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'my_foreground', // id
      'MY FOREGROUND SERVICE', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.low, // importance must be at low or higher level
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    if (Platform.isIOS || Platform.isAndroid) {
      await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          iOS: DarwinInitializationSettings(),
          android: AndroidInitializationSettings('ic_bg_service_small'),
        ),
      );
    }

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: false,
        notificationChannelId: 'my_foreground',
        initialNotificationTitle: '21 Pool Service',
        initialNotificationContent: 'Working',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
  }

  static Future<dynamic> getAllData() async {
    String token = await AuthUtils.getToken('refreshToken') ?? '';
    if (token != '') {
      var btcPrice = await ApiClient().fetchBTCPrice();
      var data = await ApiClient.get('api/v1/sub_accounts/all/');

      if (data != null) {
        int selectedSubAccount = await AuthUtils.getIndexSubAccount();
        String accountName = data[selectedSubAccount]['name'].toString();
        var dashboardData = await ApiClient.get(
            'api/v1/sub_accounts/summary/?sub_account_name=' + accountName);

        var h10 = DashboardFunctions()
            .hashrateConverter(dashboardData['hashrate_10m'].toDouble(), 2);
        var datas = {
          'subAccount': accountName.toString(),
          'hashrate': h10[0].toString() + ' ' + h10[1].toString(),
          'btc': btcPrice.toString(),
          'online': dashboardData['online_workers'].toString(),
          'offline': dashboardData['offline_workers'].toString(),
          'dead': dashboardData['dead_workers'].toString(),
          'balance': dashboardData['balance'].toString(),
        };
        return datas;
      } else {
        var datas = {
          'subAccount': 'You are not logged in!',
          'hashrate': '-',
          'btc': '-',
          'online': '-',
          'offline': '-',
          'dead': '-',
          'balance': '-'
        };
        return datas;
      }
    } else {
      var datas = {
        'subAccount': 'You are not logged in!',
        'hashrate': '-',
        'btc': '-',
        'online': '-',
        'offline': '-',
        'dead': '-',
        'balance': '-'
      };
      return datas;
    }
  }
}
