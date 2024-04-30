import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';

class CustomDataCard extends StatelessWidget {
  final String title;
  final String data;
  const CustomDataCard({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: TextStyle(color: AppColors().kPrimaryGrey, fontSize: 14),
        ),
        Text(
          data,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ]),
    );
  }
}
