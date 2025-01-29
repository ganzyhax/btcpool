import 'dart:developer';

import 'package:btcpool_app/api/api.dart';
import 'package:btcpool_app/api/api_utils.dart';
import 'package:btcpool_app/app/views/dashboard/components/dashborad_chart.dart';
import 'package:btcpool_app/app/views/dashboard/functions/functions.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:btcpool_app/local_data/user_data/user.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class WorkersInfoPage extends StatefulWidget {
  final data;
  const WorkersInfoPage({super.key, required this.data});

  @override
  State<WorkersInfoPage> createState() => _WorkersInfoPageState();
}

class _WorkersInfoPageState extends State<WorkersInfoPage> {
  Map<String, dynamic> hashrates = {};
  String selectedTime = '1HOUR';
  @override
  void initState() {
    super.initState();
    getHashrateChart();
  }

  Future<void> getHashrateChart() async {
    try {
      int selectedSubAccount = await AuthUtils.getIndexSubAccount();

      String subAccountName =
          UserData().dataSubAccounts[selectedSubAccount]['name'];
      String workerName = widget.data['worker_name'];

      hashrates = await ApiClient.get(
        'api/v1/pools/sub_accounts/worker_charts'
        '?sub_account_name=$subAccountName'
        '&worker_name=$workerName',
      );

      // Trigger UI update
      setState(() {});

      log(hashrates.toString()); // Debugging output
    } catch (e) {
      // Handle errors (e.g., network issues or API response problems)
      log('Error fetching hashrates: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;

    DateTime dateTime =
        DateTime.parse(widget.data['last_share_datetime'].toString());
    String date = DateFormat('MMM d, yyyy, HH:mm', currentLocale.toString())
        .format(dateTime);
    String hashrate10min;
    String hashrate1h;
    String hashrate24h;

    String hashrate10minType;
    String hashrate1hType;
    String hashrate24hType;

    if (widget.data['crypto_currency'] == 'BTC') {
      hashrate10min = DashboardFunctions()
          .hashrateConverter(widget.data['hashrate_10m'], 3)[0];

      hashrate1h = DashboardFunctions()
          .hashrateConverter(widget.data['hashrate_1h'], 3)[0];
      hashrate24h = DashboardFunctions()
          .hashrateConverter(widget.data['hashrate_24h'], 3)[0];
      hashrate10minType = DashboardFunctions()
          .hashrateConverter(widget.data['hashrate_10m'], 3)[1];
      hashrate1hType = DashboardFunctions()
          .hashrateConverter(widget.data['hashrate_1h'], 3)[1];
      hashrate24hType = DashboardFunctions()
          .hashrateConverter(widget.data['hashrate_24h'], 3)[1];
    } else {
      hashrate10min = DashboardFunctions()
          .hashrateConverterLTC(widget.data['hashrate_10m'], 3)[0];

      hashrate1h = DashboardFunctions()
          .hashrateConverterLTC(widget.data['hashrate_1h'], 3)[0];
      hashrate24h = DashboardFunctions()
          .hashrateConverterLTC(widget.data['hashrate_24h'], 3)[0];
      hashrate10minType = DashboardFunctions()
          .hashrateConverterLTC(widget.data['hashrate_10m'], 3)[1];
      hashrate1hType = DashboardFunctions()
          .hashrateConverterLTC(widget.data['hashrate_1h'], 3)[1];
      hashrate24hType = DashboardFunctions()
          .hashrateConverterLTC(widget.data['hashrate_24h'], 3)[1];
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(LocaleKeys.workers.tr()),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            data_widget(LocaleKeys.worker.tr(), widget.data['worker_name']),
            data_widget(
                LocaleKeys.status.tr(),
                (widget.data['status'] == 'ONLINE')
                    ? LocaleKeys.online.tr()
                    : (widget.data['status'] == 'DEAD')
                        ? 'Inactive'
                        : LocaleKeys.offline.tr()),
            data_widget(LocaleKeys.hashrate_10m.tr(),
                hashrate10min + ' ' + hashrate10minType),
            data_widget(
                LocaleKeys.hashrate_1h.tr(), hashrate1h + ' ' + hashrate1hType),
            data_widget(LocaleKeys.hashrate_24h.tr(),
                hashrate24h + ' ' + hashrate24hType),
            data_widget(LocaleKeys.last_share_time.tr(), date),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.chart.tr(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            (hashrates.isNotEmpty)
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).colorScheme.secondary),
                    padding: EdgeInsets.all(7),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedTime = '1HOUR';
                                });
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 7,
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "1 ",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors().kPrimaryGreen,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        LocaleKeys.hour,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors().kPrimaryGreen,
                                            fontWeight: FontWeight.w600),
                                      ).tr(),
                                    ],
                                  ),
                                  Divider(
                                    thickness:
                                        (selectedTime == '1HOUR') ? 3 : 1,
                                    color: AppColors().kPrimaryGreen,
                                  )
                                ]),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedTime = '24HOUR';
                                });
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 7,
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "24 ",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors().kPrimaryGreen,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        LocaleKeys.hour,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors().kPrimaryGreen,
                                            fontWeight: FontWeight.w600),
                                      ).tr(),
                                    ],
                                  ),
                                  Divider(
                                    thickness:
                                        (selectedTime == '24HOUR') ? 3 : 1,
                                    color: AppColors().kPrimaryGreen,
                                  )
                                ]),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(20)),
                            height: MediaQuery.of(context).size.height / 3.2,
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 0, bottom: 25),
                            width: MediaQuery.of(context).size.width,
                            child: MiningPowerChart(
                                currentCurrency: hashrates['crypto_currency'],
                                times: hashrates['hashrates'][selectedTime]
                                    .keys
                                    .map((timestamp) {
                                  return DateTime.fromMillisecondsSinceEpoch(
                                    (int.parse(timestamp.toString())) * 1000,
                                    isUtc: true,
                                  );
                                }).toList(),
                                powerValues: hashrates['hashrates']
                                        [selectedTime]
                                    .values
                                    .map((speed) {
                                  return (speed as num).toDouble();
                                }).toList())),
                      ],
                    ),
                  )
                : SizedBox()
          ],
        ),
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
          style: const TextStyle(fontSize: 16),
        ),
      ]),
    );
  }
}
