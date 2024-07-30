import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/subaccount/bloc/subaccount_bloc.dart';

import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';
import 'package:btcpool_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class SubaccountSplittedEditModal extends StatefulWidget {
  var accountData;
  SubaccountSplittedEditModal({super.key, required this.accountData});
  @override
  State<SubaccountSplittedEditModal> createState() =>
      _SubaccountSplittedEditModalState();
}

class _SubaccountSplittedEditModalState
    extends State<SubaccountSplittedEditModal> {
  // List to hold wallet and percentage text controllers
  late List<TextEditingController> walletControllers;
  late List<TextEditingController> percentageControllers;

  @override
  void initState() {
    super.initState();
    walletControllers = List.generate(
        widget.accountData['virtual_sub_accounts'].length,
        (index) => TextEditingController(
            text: widget.accountData['virtual_sub_accounts'][index]
                ['wallet_address']));
    percentageControllers = List.generate(
        widget.accountData['virtual_sub_accounts'].length,
        (index) => TextEditingController(
            text: double.parse(widget.accountData['virtual_sub_accounts'][index]
                        ['percentage']
                    .toString())
                .toStringAsFixed(0)));
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
              mainAxisSize: MainAxisSize.min,
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
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            child:
                                                Text(LocaleKeys.account.tr())),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            child:
                                                Text(LocaleKeys.wallet.tr())),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            child: const Text('%')),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: List.generate(
                                        widget
                                            .accountData['virtual_sub_accounts']
                                            .length,
                                        (index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            6,
                                                    child: Text(widget
                                                                .accountData[
                                                            'virtual_sub_accounts']
                                                        [index]['name'])),
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            4,
                                                    child: CustomTextField(
                                                        hintText: LocaleKeys
                                                            .wallet
                                                            .tr(),
                                                        controller:
                                                            walletControllers[
                                                                index])),
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            4,
                                                    child: CustomTextField(
                                                        hintText: LocaleKeys
                                                            .wallet
                                                            .tr(),
                                                        controller:
                                                            percentageControllers[
                                                                index])),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    )
                                  ],
                                ),
                                (widget.accountData['virtual_sub_accounts'][0]
                                            ['active_update_request'] ==
                                        null)
                                    ? CustomButton(
                                        isLoading: state.isLoading,
                                        text: LocaleKeys.create.tr(),
                                        function: () {
                                          for (int i = 0;
                                              i < walletControllers.length;
                                              i++) {
                                            widget.accountData[
                                                        'virtual_sub_accounts']
                                                    [i]['wallet_address'] =
                                                walletControllers[i]
                                                    .text
                                                    .toString();
                                            widget.accountData[
                                                        'virtual_sub_accounts']
                                                    [i]['percentage'] =
                                                percentageControllers[i]
                                                    .text
                                                    .toString();
                                          }

                                          var data = {
                                            'name': widget.accountData['name']
                                                .toString(),
                                            'sub_account_id': widget
                                                .accountData['id']
                                                .toString(),
                                            'virtual_sub_accounts':
                                                widget.accountData[
                                                    'virtual_sub_accounts'],
                                          };
                                          BlocProvider.of<SubaccountBloc>(
                                                  context)
                                              .add(
                                                  SubaccountSplittedAccountUpdate(
                                                      data: data));
                                        },
                                      )
                                    : Text(
                                        LocaleKeys
                                            .your_previus_application_is_under_review
                                            .tr(),
                                        style: const TextStyle(
                                            color: Colors.amber),
                                        textAlign: TextAlign.start,
                                      )
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
