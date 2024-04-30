import 'package:btcpool_app/app/widgets/appbar/custom_title_appbar.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';
import 'package:btcpool_app/app/widgets/custom_data_card.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().kPrimaryBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomTitleAppBar(
          title: 'Personal Settings',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomDataCard(
                title: 'Your user name:',
                data: 'Username',
              ),
              CustomDataCard(
                title: 'Your e-mail:',
                data: 'email@gmail.com',
              ),
              CustomDataCard(
                title: 'Pool fee:',
                data: '2,5%',
              ),
              CustomDataCard(
                title: 'Current password:',
                data: '******',
              ),
              CustomButton(
                text: 'Change',
                function: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
