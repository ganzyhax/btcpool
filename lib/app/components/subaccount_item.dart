import 'package:btcpool_app/local_data/const.dart';
import 'package:flutter/material.dart';

class SubAccountItem extends StatelessWidget {
  final String title;
  const SubAccountItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            Icon(
              Icons.person,
              color: AppColors().kPrimaryGreen,
            ),
            Text(
              title,
              style: TextStyle(color: AppColors().kPrimaryGreen),
            )
          ],
        ),
        Icon(Icons.arrow_forward_ios_sharp)
      ]),
    );
  }
}
