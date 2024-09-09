import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:btcpool_app/api/api.dart';
import 'package:btcpool_app/api/api_utils.dart';
import 'package:btcpool_app/app/app.dart';
import 'package:btcpool_app/app/components/buttons/custom_button.dart';
import 'package:btcpool_app/app/components/custom_snackbar.dart';
import 'package:btcpool_app/app/components/textfields/custom_textfiled.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class AccDeleteModal extends StatefulWidget {
  final scaffoldKey;
  const AccDeleteModal({super.key, required this.scaffoldKey});
  @override
  State<AccDeleteModal> createState() => _AccDeleteModalState();
}

class _AccDeleteModalState extends State<AccDeleteModal> {
  TextEditingController name = TextEditingController();
  String errorText = '';
  @override
  void initState() {
    super.initState();
    // Setup a listener to update the UI based on text changes
    name.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

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
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.secondary,
                offset: const Offset(0, 10),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                LocaleKeys.delete_account.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue),
              ),
              const SizedBox(height: 15),
              Text(
                LocaleKeys.confirm_delete_account.tr(),
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                  hintText: LocaleKeys.username_login.tr(), controller: name),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: CustomButton(
                      text: LocaleKeys.cancel.tr(),
                      color: Colors.grey[500],
                      function: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: CustomButton(
                      text: LocaleKeys.delete.tr(),
                      color: Colors.red,
                      isEnable: (name.text.isEmpty) ? false : true,
                      function: () async {
                        String userName = await AuthUtils.getUserName();
                        String userId = await AuthUtils.getUserId();

                        // try {
                        //   if (name.text == userName) {
                        //     var data = await ApiClient.del(
                        //         'api/v1/users/delete/$userId/', {});

                        //     if (data == true) {
                        //       await AuthUtils.logout();
                        //       Navigator.pushAndRemoveUntil(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) => BTCPool()),
                        //           (route) => false);
                        //     } else {
                        //       if (data.containsKey('title')) {
                        //         setState(() {
                        //           errorText = data['title'];
                        //         });
                        //       } else {
                        //         setState(() {
                        //           errorText = 'Please retry later';
                        //         });
                        //       }
                        //     }
                        //   } else {
                        //     setState(() {
                        //       errorText = LocaleKeys
                        //           .account_delete_dont_match_error
                        //           .tr();
                        //     });
                        //   }
                        // } catch (e) {
                        //   print(e);
                        // }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              (errorText == '')
                  ? const SizedBox()
                  : Text(
                      errorText,
                      style: const TextStyle(color: Colors.red),
                    )
            ],
          ),
        ),
      ],
    );
  }
}
