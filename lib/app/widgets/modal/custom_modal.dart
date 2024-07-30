import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:btcpool_app/app/screens/settings/pages/subaccount/components/subaccount_new_create_account.dart';
import 'package:btcpool_app/app/screens/settings/pages/subaccount/subaccount_page.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class CustomModal extends StatelessWidget {
  const CustomModal({super.key});

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
              SvgPicture.asset('assets/icons/create_subaccount_modal_icon.svg'),
              const SizedBox(
                height: 25,
              ),
              Text(
                LocaleKeys.no_subaccounts.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.orange),
              ),
              const SizedBox(height: 15),
              Text(
                LocaleKeys.create_subaccount_required.tr(),
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 22),
              Align(
                alignment: Alignment.center,
                child: CustomButton(
                  text: LocaleKeys.create_new_subaccount.tr(),
                  function: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => SubAccountCreateNewAccount()),
                        (Route<dynamic> route) => false);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
