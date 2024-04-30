import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';

class WorkersInfoPage extends StatelessWidget {
  const WorkersInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workers'),
      ),
      backgroundColor: AppColors().kPrimaryBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          data_widget('Worker', 'User 312'),
          data_widget('Status', 'User 312'),
          data_widget('Hashrate 10 min', 'User 312'),
          data_widget('Hashrate 1 hour', 'User 312'),
          data_widget('Hashrate 24 hour', '111,21 TH/s'),
          data_widget('Last share time', 'Mar 12, 2024, 11:13'),
        ],
      ),
    );
  }

  data_widget(title, data) {
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
