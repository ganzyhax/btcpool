import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:btcpool_app/api/local_auth.dart';
import 'package:btcpool_app/app/views/navigator/main_navigator.dart';
import 'package:btcpool_app/app/components/buttons/custom_button.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class LockPage extends StatefulWidget {
  const LockPage({super.key});

  @override
  State<LockPage> createState() => _LockPageState();
}

class _LockPageState extends State<LockPage> {
  @override
  void initState() {
    faceId();
  }

  faceId() async {
    bool isPermission = await LocalAuth().authenticate();

    if (isPermission) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => CustomNavigationBar()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height / 7),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    radius: 50,
                    child: Icon(
                      Icons.lock,
                      size: 50,
                      color: AppColors().kPrimaryGreen,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(
                      LocaleKeys.unlock_pool.tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Text(
                      LocaleKeys.to_unlock_pool.tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              child: CustomButton(
                  function: () async {
                    await faceId();
                  },
                  text: LocaleKeys.unlock_with_faceid.tr()),
            ),
          ),
        ],
      ),
    );
  }
}
