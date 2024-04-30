import 'package:btcpool_app/app/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/subaccount/bloc/subaccount_bloc.dart';
import 'package:btcpool_app/app/widgets/appbar/custom_appbar.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_dropdown_button.dart';
import 'package:btcpool_app/app/widgets/custom_snackbar.dart';
import 'package:btcpool_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class SubAccountPage extends StatelessWidget {
  const SubAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController wallet = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors().kPrimaryBackgroundColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar(
            withArrow: true,
            withSubAccount: false,
            title: 'Create subaccount',
          )),
      body: BlocListener<SubaccountBloc, SubaccountState>(
        listener: (context, state) {
          if (state is SubaccountError) {
            CustomSnackbar().showCustomSnackbar(context, state.message, false);
          }
          if (state is SubaccountSuccess) {
            CustomSnackbar().showCustomSnackbar(context, state.message, true);
            Navigator.pop(context);
            BlocProvider.of<DashboardBloc>(context)..add(DashboardLoad());
          }
          // TODO: implement listener
        },
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 7,
                  ),
                  Text('Name'),
                  SizedBox(
                    height: 14,
                  ),
                  CustomTextField(hintText: 'Name', controller: name),
                  SizedBox(
                    height: 14,
                  ),
                  Text('Wallet adress'),
                  SizedBox(
                    height: 14,
                  ),
                  CustomTextField(hintText: 'Wallet', controller: wallet),
                  SizedBox(
                    height: 14,
                  ),
                  Text('Method'),
                  SizedBox(
                    height: 14,
                  ),
                  CustomDropdownButton(
                      function: (value) {
                        print(value);
                      },
                      selectedValue: 'FPPS',
                      items: [
                        DropdownMenuItem(
                          value: 'FPPS',
                          child: Text('FPPS'),
                        ),
                        DropdownMenuItem(
                          value: 'PPS',
                          child: Text('PPS'),
                        )
                      ]),
                  SizedBox(
                    height: 14,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CustomButton(
                    text: 'Create',
                    function: () {
                      if (name.text.length != 0 && wallet.length != 0) {
                        BlocProvider.of<SubaccountBloc>(context)
                          ..add(SubaccountCreate(
                              name: name.text, wallet: wallet.text));
                      } else {
                        CustomSnackbar().showCustomSnackbar(
                            context, 'Please fill all blanks!', true);
                      }
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
