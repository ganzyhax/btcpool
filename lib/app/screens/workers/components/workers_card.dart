import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';

class WorkersCard extends StatelessWidget {
  final bool isOnline;
  const WorkersCard({super.key, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors().kPrimaryWhite),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 1.25,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      width: 17 / 2,
                      height: 17 / 2,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'User Name',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Mar 12, 2024, 11:13',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current',
                          style: TextStyle(
                              fontSize: 14, color: AppColors().kPrimaryGrey),
                        ),
                        Text('1,86 EH/s',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1H',
                          style: TextStyle(
                              fontSize: 14, color: AppColors().kPrimaryGrey),
                        ),
                        Text('1,86 EH/s',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '24 H',
                          style: TextStyle(
                              fontSize: 14, color: AppColors().kPrimaryGrey),
                        ),
                        Text('1,86 EH/s',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ))
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: 12,
            child: Icon(
              Icons.arrow_forward_ios_outlined,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
