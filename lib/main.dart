import 'package:btcpool_app/api/api_utils.dart';
import 'package:btcpool_app/app/app.dart';
import 'package:btcpool_app/controller/background_controller.dart';
import 'package:btcpool_app/controller/dependency_inejction.dart';
import 'package:btcpool_app/controller/home_widget_controller.dart';
import 'package:btcpool_app/generated/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // setupLocator();
  // await AuthUtils.clearStorage();
  DependencyInjection.init();
  await AuthUtils.saveMobileVersion();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  // HomeWidgetController().init();
  // BackgroundService().initializeService();

  runApp(
    EasyLocalization(
        supportedLocales: [
          Locale('en'),
          Locale('ru'),
          Locale('es'),
          Locale('pt'),
          Locale('ar'),
        ],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        assetLoader: CodegenLoader(),
        child: BTCPool()),
  );
}
