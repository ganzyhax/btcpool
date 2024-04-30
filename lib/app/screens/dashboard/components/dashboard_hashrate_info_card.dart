import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardHashrateInfoCard extends StatelessWidget {
  final data;
  final String title;
  final bool isHashrate;

  const DashboardHashrateInfoCard(
      {super.key,
      required this.data,
      required this.title,
      required this.isHashrate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.2,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors().kPrimaryWhite),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: AppColors().kPrimaryGrey, fontSize: 16),
          ),
          SizedBox(
            height: 5,
          ),
          (isHashrate == false)
              ? Row(
                  children: [
                    SizedBox(
                        width: 120,
                        child: Text(
                          data[0].toStringAsFixed(2) +
                              '/' +
                              data[1].toStringAsFixed(2),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Text(
                      'EH/s',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors().kPrimaryGrey),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Text(data[0].toString(),
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)),
                    Text('/',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    Text(data[1].toString(),
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                )
        ],
      ),
    );
  }
}
