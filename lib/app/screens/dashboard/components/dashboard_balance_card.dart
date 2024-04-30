import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardInfoCard extends StatelessWidget {
  final data;
  final String title;
  const DashboardInfoCard({super.key, required this.data, required this.title});

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
          Row(
            children: [
              SizedBox(
                height: 30,
                child: Image.asset('assets/images/btc_logo.png'),
              ),
              SizedBox(
                width: 10,
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 80,
                          child: Text(
                            data.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        width: 80,
                        child: Text(
                          '=' + data.toString() + '\$',
                          style: TextStyle(color: AppColors().kPrimaryGrey),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'BTC',
                    style: TextStyle(color: AppColors().kPrimaryGrey),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
            ],
          )
        ],
      ),
    );
  }
}
