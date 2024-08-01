import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/subaccount/bloc/subaccount_bloc.dart';

import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_checkbox.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_dropdown_button.dart';
import 'package:btcpool_app/app/widgets/custom_indicator.dart';
import 'package:btcpool_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class SubaccountCreateModal extends StatefulWidget {
  const SubaccountCreateModal({super.key});

  @override
  State<SubaccountCreateModal> createState() => _SubaccountCreateModalState();
}

class _SubaccountCreateModalState extends State<SubaccountCreateModal> {
  TextEditingController name = TextEditingController();
  TextEditingController wallet = TextEditingController();
  TextEditingController h1 = TextEditingController();
  TextEditingController h2 = TextEditingController();
  TextEditingController h3 = TextEditingController();
  TextEditingController empty = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    name.addListener(_onTextChanged);
    wallet.addListener(_onTextChanged);
    h1.addListener(_onTextChanged);
    h2.addListener(_onTextChanged);
    h3.addListener(_onTextChanged);
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      if (h3.text.endsWith('%')) {
        h3.text = h3.text.substring(0, h3.text.length - 1);
      }
    } else {
      if (!h3.text.endsWith('%') && h3.text.isNotEmpty) {
        h3.text = '${h3.text}%';
      }
    }
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
                                  LocaleKeys.create_new_subaccount.tr(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors().kPrimaryGreen),
                                )),
                                const SizedBox(
                                  height: 7,
                                ),
                                Text(LocaleKeys.name.tr()),
                                const SizedBox(
                                  height: 14,
                                ),
                                CustomTextField(
                                    hintText: LocaleKeys.name.tr(),
                                    controller: name),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(LocaleKeys.wallet_address.tr()),
                                const SizedBox(
                                  height: 14,
                                ),
                                CustomTextField(
                                    hintText: LocaleKeys.wallet.tr(),
                                    controller: wallet),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(LocaleKeys.method.tr()),
                                const SizedBox(
                                  height: 14,
                                ),
                                CustomDropdownButton(
                                    function: (value) {},
                                    selectedValue: 'FPPS',
                                    items: [
                                      const DropdownMenuItem(
                                        value: 'FPPS',
                                        child: Text(
                                          'FPPS',
                                        ),
                                      ),
                                      const DropdownMenuItem(
                                        value: 'PPS',
                                        child: Text(
                                          'PPS',
                                        ),
                                      ),
                                    ]),
                                const SizedBox(
                                  height: 24,
                                ),
                                CustomButton(
                                  text: LocaleKeys.create.tr(),
                                  isLoading: state.isLoading,
                                  isEnable:
                                      (name.text.isEmpty || wallet.text.isEmpty)
                                          ? false
                                          : true,
                                  function: () {
                                    print('asdadasd');
                                    BlocProvider.of<SubaccountBloc>(context)
                                        .add(SubaccountCreate(
                                            name: name.text,
                                            wallet: wallet.text));
                                  },
                                ),
                              ],
                            )),
                      );
                    }
                    return Center(child: CustomIndicator());
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
