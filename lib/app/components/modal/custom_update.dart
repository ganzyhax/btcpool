import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:btcpool_app/api/api_utils.dart';
import 'package:btcpool_app/app/views/login/login_screen.dart';
import 'package:btcpool_app/app/views/navigator/main_navigator.dart';
import 'package:btcpool_app/app/components/buttons/custom_button.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateModal extends StatelessWidget {
  final bool? withSkip;
  final Function()? onClose;
  const UpdateModal({super.key, this.withSkip, this.onClose});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgPicture.asset(
                'assets/icons/update_icon.svg',
                color: Colors.green,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                textAlign: TextAlign.center,
                LocaleKeys.update.tr(),
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.orange),
              ),
              const SizedBox(height: 15),
              Text(
                LocaleKeys.new_version_available.tr(),
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 22),
              Align(
                alignment: Alignment.center,
                child: CustomButton(
                  text: LocaleKeys.update.tr(),
                  function: () async {
                    if (Platform.isIOS) {
                      const String appStoreUrl =
                          'https://play.google.com/store/apps/details?id=com.pool.twpool_app';
                      if (await canLaunch(appStoreUrl)) {
                        await launch(appStoreUrl);
                      }
                    } else {
                      const String appStoreUrl =
                          'https://apps.apple.com/app/btcpool-%D0%B0%D0%BA%D0%BA%D1%80%D0%B5%D0%B4%D0%B8%D1%82%D0%BE%D0%B2%D0%B0%D0%BD%D0%BD%D1%8B%D0%B9-%D0%BF%D1%83%D0%BB/id6633424420';
                      if (await canLaunch(appStoreUrl)) {
                        await launch(appStoreUrl);
                      }
                    }
                    bool isLogged = await AuthUtils.isAccess();

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => (isLogged)
                              ? CustomNavigationBar()
                              : LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              (withSkip == true)
                  ? InkWell(
                      onTap: () async {
                        await AuthUtils.setRecUpdateSkip();
                        Navigator.pop(context);
                      },
                      child: Text(
                        LocaleKeys.skip.tr(),
                        style: TextStyle(color: Colors.grey[500], fontSize: 18),
                      ))
                  : const SizedBox()
            ],
          ),
        ),
      ],
    );
  }
}
