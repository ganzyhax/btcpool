import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/subaccount/bloc/subaccount_bloc.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';

import 'package:btcpool_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class SubaccountEditWalletModal extends StatefulWidget {
  var accountData;
  SubaccountEditWalletModal({super.key, required this.accountData});
  @override
  State<SubaccountEditWalletModal> createState() =>
      _SubaccountEditWalletModalState();
}

class _SubaccountEditWalletModalState extends State<SubaccountEditWalletModal> {
  TextEditingController wallet = TextEditingController();
  @override
  void initState() {
    super.initState();
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
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BlocBuilder<SubaccountBloc, SubaccountState>(
                  builder: (context, state) {
                    if (state is SubaccountLoaded) {
                      return SingleChildScrollView(
                        child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 15, bottom: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Icon(Icons.close))
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Center(
                                    child: Text(
                                  LocaleKeys.edit_wallet_address.tr(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors().kPrimaryGreen),
                                )),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      LocaleKeys.current_wallet_address.tr(),
                                      style: TextStyle(color: Colors.grey[400]),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(widget.accountData['wallet_address']),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      LocaleKeys.new_wallet_address.tr(),
                                      style: TextStyle(color: Colors.grey[400]),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    CustomTextField(
                                        hintText:
                                            LocaleKeys.wallet_address.tr(),
                                        controller: wallet),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(LocaleKeys.the_added_and_changed_wallet
                                        .tr()),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    CustomButton(
                                      text: LocaleKeys.change.tr(),
                                      isLoading: state.isLoading,
                                      function: () {
                                        var data = {
                                          'name': widget.accountData['name'],
                                          'sub_account_id':
                                              widget.accountData['id'],
                                          'wallet_address': wallet.text
                                        };
                                        BlocProvider.of<SubaccountBloc>(context)
                                            .add(SubaccountWalletAccountUpdate(
                                                data: data));
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
