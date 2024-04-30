import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';

class DashboardUrlCard extends StatelessWidget {
  final data;
  const DashboardUrlCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors().kPrimaryWhite),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The worker name (after the dot) can be arbitrary, must consist of numbers or lowercase letters, and the maximum length is 30 characters.',
            style: TextStyle(color: AppColors().kPrimaryGrey, fontSize: 13),
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data.map<Widget>((e) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(e['description'],
                      style: TextStyle(
                          color: AppColors().kPrimaryGrey, fontSize: 13)),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        padding: EdgeInsets.only(left: 25, top: 15, bottom: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            border:
                                Border.all(color: AppColors().kPrimaryGrey)),
                        child: Text(e['url']),
                      ),
                      Container(
                        padding: EdgeInsets.all(13),
                        child: Center(
                          child: Icon(
                            Icons.copy,
                            color: AppColors().kPrimaryGreen,
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border:
                                Border.all(color: AppColors().kPrimaryGreen)),
                      )
                    ],
                  ),
                ],
              );
            }).toList(),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
