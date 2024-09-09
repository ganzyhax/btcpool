import 'package:btcpool_app/api/api_utils.dart';
import 'package:btcpool_app/app/app.dart';
import 'package:btcpool_app/controllers/dependency_inejction.dart';
import 'package:btcpool_app/generated/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await AuthUtils.saveMobileVer();
  DependencyInjection.init();
  runApp(
    EasyLocalization(
        supportedLocales: [
          Locale('ru'),
          Locale('kk'),
        ],
        path: 'assets/translations',
        fallbackLocale: Locale('ru'),
        assetLoader: CodegenLoader(),
        child: BTCPool()),
  );
}
