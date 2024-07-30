import 'package:btcpool_app/app/screens/dashboard/functions/functions.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';

class WorkersHashrateInfoCard extends StatelessWidget {
  final data;
  final String title;

  const WorkersHashrateInfoCard({
    super.key,
    required this.data,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var h10 = DashboardFunctions().hashrateConverter(data[0].toDouble(), 1);
    var h1 = DashboardFunctions().hashrateConverter(data[1].toDouble(), 1);

    var h24 = DashboardFunctions().hashrateConverter(data[2].toDouble(), 1);
    return Container(
      width: MediaQuery.of(context).size.width / 2.2,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.secondary),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: AppColors().kPrimaryGrey, fontSize: 16),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Text(
                    h10[0] + '/' + h1[0] + '/' + h24[0],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12),
                  )),
              Text(
                h24[1],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors().kPrimaryGrey,
                    fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}
