import 'dart:developer';

import 'package:btcpool_app/local_data/const.dart';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class MiningPowerChart extends StatelessWidget {
  final List<dynamic> times; // List of times

  final List<dynamic> powerValues;
  final double? max;
  final String currentCurrency;
  const MiningPowerChart(
      {super.key,
      required this.powerValues,
      this.max,
      required this.times,
      required this.currentCurrency});

  @override
  Widget build(BuildContext context) {
    double customRound(double value) {
      double rounded = (value * 20).roundToDouble() / 20;

      return rounded;
    }

    List<double> roundedValues = powerValues.map((value) {
      double rounded;
      if (currentCurrency != 'LTC') {
        double inTh = value / 1e6;

        rounded = inTh.roundToDouble();
      } else {
        double inGs = value / 1000;

        rounded = customRound(inGs);
      }

      return rounded;
    }).toList();
    double maxRoundedValue =
        roundedValues.reduce((value, max) => value > max ? value : max);

    double roundedMax = ((maxRoundedValue).ceil()).toDouble();
    double maxY = 0;
    if (currentCurrency != 'LTC') {
      if (roundedMax < 1000) {
        if (roundedMax % 50 == 0) {
          maxY = roundedMax;
        } else {
          int check = roundedMax ~/ 50;

          check = check + 1;
          maxY = check * 50;
        }
        if (maxY == 0) {
          maxY = 50;
        }
      }

      if (roundedMax >= 1000) {
        //PH

        if (roundedMax % 5000 == 0) {
          maxY = roundedMax;
        } else {
          int check = roundedMax ~/ 5000;

          check = check + 1;
          maxY = check * 5000;
        }
        if (maxY == 0) {
          maxY = 5000;
        }
      }
      if (roundedMax >= 1000000) {
        //Eh
        if (roundedMax % 5000000 == 0) {
          maxY = roundedMax;
        } else {
          int check = roundedMax ~/ 5000000;

          check = check + 1;
          maxY = check * 5000000;
        }
        if (maxY == 0) {
          maxY = 5000000;
        }
      }
    } else {
      if (roundedMax >= 100) {
        if (roundedMax % 10 == 0) {
          maxY = maxRoundedValue;
        } else {
          int check = roundedMax ~/ 10;

          check = check + 1;
          maxY = check * 10;
          maxY = maxY + 50;
          int result = maxY ~/ 100;
          maxY = result * 100;
        }
      } else {
        maxY = maxRoundedValue;

        if (maxY > 0.99) {
          maxY = (maxY / 2).ceil() * 2;
        } else {
          maxY = maxRoundedValue;
          maxY = (maxY * 10).round() / 10;
        }
      }
    }

    // var times = DashboardFunctions().getLastHourDivided(12);

    // if (powerValues.length == 13) {
    //   times = DashboardFunctions().getLastHourDivided(12);
    //   times = times.reversed.toList();
    // } else if (powerValues.length == 49) {
    //   times = DashboardFunctions().getLast24HoursDivided(48);
    // } else {
    //   times = DashboardFunctions().getLastMonthDivided(30);
    // }

    List<FlSpot> spots = List.generate(times.length, (index) {
      final time = times[index].millisecondsSinceEpoch.toDouble();

      return (currentCurrency != 'LTC')
          ? FlSpot(time, (powerValues[index] / 1e6))
          : FlSpot(time, (powerValues[index] / 1000));
    });

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        lineTouchData: LineTouchData(
            getTouchedSpotIndicator: (barData, spotIndexes) {
              return spotIndexes.map((spotIndex) {
                return TouchedSpotIndicatorData(
                  FlLine(color: Colors.blue, strokeWidth: 0),
                  FlDotData(
                      show: true,
                      checkToShowDot: (spot, barData) {
                        return true;
                      },
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 6,
                          color: Colors.blue,
                          strokeWidth: 0,
                          strokeColor: Colors.transparent,
                        );
                      }),
                );
              }).toList();
            },
            touchTooltipData: LineTouchTooltipData(
                fitInsideHorizontally: true,
                getTooltipColor: (LineBarSpot touchedSpot) =>
                    Theme.of(context).colorScheme.background,

                // tooltipBgColor: Theme.of(context).colorScheme.background,
                getTooltipItems: (List<LineBarSpot> touchTooltipData) {
                  return touchTooltipData.map((data) {
                    var date = DateTime.fromMillisecondsSinceEpoch(
                        data.x.toInt(),
                        isUtc: true);
                    DateTime localDateTime = date.toLocal();

                    String strDate = DateFormat('d MMM, yyyy, HH:mm')
                        .format(localDateTime)
                        .toString();

                    return (currentCurrency != 'LTC')
                        ? LineTooltipItem(
                            (data.y < 1000)
                                ? '${(data.y).toStringAsFixed(3)} TH/s\n$strDate'
                                : (data.y >= 1000 && data.y < 1000000)
                                    ? '${(data.y / 1000).toStringAsFixed(3)} PH/s\n$strDate'
                                    : '${(data.y / 1000000).toStringAsFixed(3)} EH/s\n$strDate',
                            const TextStyle(fontWeight: FontWeight.bold),
                          )
                        : LineTooltipItem(
                            (data.y.toInt() > 100)
                                ? '${(data.y).toStringAsFixed(3)} GH/s\n$strDate'
                                : '${(data.y).toStringAsFixed(3)} GH/s\n$strDate',
                            const TextStyle(fontWeight: FontWeight.bold),
                          );
                  }).toList();
                })),
        titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: false,
            )),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: false,
              getTitlesWidget: (value, meta) {
                var date = DateTime.fromMillisecondsSinceEpoch(value.toInt(),
                    isUtc: true);
                DateTime localDateTime = date.toLocal();

                return Text(
                  DateFormat('HH:mm').format(localDateTime).toString(),
                  style: TextStyle(fontSize: 10, color: Colors.grey[400]),
                );
              },
            )),
            leftTitles: (currentCurrency != 'LTC')
                ? AxisTitles(
                    sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: (maxY.toString().length == 5)
                        ? 50
                        : (maxY.toString().length == 2)
                            ? 5000000
                            : 5000000,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        (value < 1000)
                            ? '${(value.toInt()).toStringAsFixed(0)}TH'
                            : (value >= 1000 && value < 1000000)
                                ? '${(value.toInt() / 1000).toStringAsFixed(0)}PH'
                                : '${(value.toInt() / 1000000).toStringAsFixed(0)}EH',
                        style: TextStyle(fontSize: 8, color: Colors.grey[500]),
                      );
                    },
                  ))
                : AxisTitles(
                    sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: (maxY >= 100) ? 0.050 * 1000 : 5,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        '${(value).toStringAsFixed(3)} GH/s',
                        style: TextStyle(fontSize: 8, color: Colors.grey[500]),
                      );
                    },
                  ))),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: AppColors().kPrimaryGreen,
            barWidth: 1.5,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              color: AppColors().kPrimaryGreen.withOpacity(0.3),
              // gradient: AppColors().kPrimaryGradientChartGreenColor,
              show: true,
            ),
          ),
        ],
        minX: spots.first.x,
        maxX: spots.last.x,
        minY: 0,
        maxY: maxY,
      ),
    );
  }
}
