import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:btcpool_app/app/screens/settings/pages/referral/bloc/referral_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/subaccount/subaccount_page.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';
import 'package:btcpool_app/app/widgets/custom_indicator.dart';
import 'package:btcpool_app/app/widgets/custom_snackbar.dart';
import 'package:btcpool_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class ReferralGenerateModal extends StatefulWidget {
  const ReferralGenerateModal({super.key});

  @override
  State<ReferralGenerateModal> createState() => _ReferralGenerateModalState();
}

class _ReferralGenerateModalState extends State<ReferralGenerateModal> {
  List percentages = [
    '0.8',
    '0.9',
    '1.0',
    '1.1',
    '1.2',
    '1.3',
    '1.4',
    '1.5',
    '1.6',
    '1.7',
    '1.8',
    '1.9',
    '2.0'
  ];
  TextEditingController wallet = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Setup a listener to update the UI based on text changes
    wallet.addListener(_onTextChanged);
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
    return BlocListener<ReferralBloc, ReferralState>(
      listener: (context, state) {
        if (state is ReferralSuccess) {
          CustomSnackbar().showCustomSnackbar(context, state.message, true);
          Navigator.pop(context, true);
        }
        if (state is ReferralError) {
          CustomSnackbar().showCustomSnackbar(context, state.message, false);
        }
      },
      child: BlocBuilder<ReferralBloc, ReferralState>(
        builder: (context, state) {
          if (state is ReferralLoaded) {
            return Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, right: 20, bottom: 20),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // SvgPicture.asset('assets/icons/create_subaccount_modal_icon.svg'),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.8,
                              child: Text(
                                LocaleKeys.generate_referral_link.tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors().kPrimaryGreen),
                              ),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.close,
                              )),
                        ],
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                          hintText: LocaleKeys.wallet_address.tr(),
                          controller: wallet),
                      const SizedBox(height: 15),
                      Text(
                        LocaleKeys.pool_fee_for_client.tr() + ' %',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      const SizedBox(height: 6),
                      MultiSelectDropDown<String>(
                        onOptionSelected:
                            (List<ValueItem<String>> selectedOptions) {
                          BlocProvider.of<ReferralBloc>(context).add(
                              ReferralSelectPoolFee(
                                  value: double.parse(
                                      selectedOptions[0].value.toString())));
                        },
                        options:
                            percentages.map<ValueItem<String>>((subAccount) {
                          return ValueItem<String>(
                            label: subAccount,
                            value: subAccount,
                          );
                        }).toList(),
                        dropdownBackgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        selectionType: SelectionType.single,
                        chipConfig: const ChipConfig(wrapType: WrapType.scroll),
                        dropdownHeight: 210,
                        optionTextStyle: const TextStyle(fontSize: 16),
                        selectedOptionTextColor: AppColors().kPrimaryGreen,
                        selectedOptionBackgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        hint: '0.8',
                        searchBackgroundColor: AppColors().kPrimaryGreen,
                        selectedOptionIcon: const Icon(Icons.check_circle),
                        fieldBackgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        optionsBackgroundColor:
                            Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        LocaleKeys.referral_fee.tr() + ' %',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      const Text(
                        '30%',
                      ),

                      const SizedBox(height: 15),
                      Text(
                        LocaleKeys.reward_fee.tr() + '  %',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      Text('${(30 / 100) * state.selectedPoolFee}%'),

                      const SizedBox(height: 22),
                      Align(
                        alignment: Alignment.center,
                        child: CustomButton(
                          text: LocaleKeys.generate.tr(),
                          isEnable: (wallet.text.isNotEmpty) ? true : false,
                          function: () {
                            BlocProvider.of<ReferralBloc>(context)
                                .add(ReferralGenerateLink(wallet: wallet.text));
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            );
          }
          return Center(
            child: CustomIndicator(),
          );
        },
      ),
    );
  }
}
