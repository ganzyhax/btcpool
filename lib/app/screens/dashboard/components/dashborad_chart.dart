import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class MiningPowerChart extends StatelessWidget {
  final List<dynamic> times; // List of times
  final List<dynamic> powerValues; // Corresponding list of power values in TH/s
  final double? max;
  MiningPowerChart({required this.times, required this.powerValues, this.max});

  @override
  Widget build(BuildContext context) {
    List<double> roundedValues = powerValues.map((value) {
      double inMillions = value / 1e6; // Convert to millions
      double rounded = (inMillions / 100).roundToDouble() *
          100; // Round to nearest hundred thousand
      return rounded;
    }).toList();

    double maxRoundedValue =
        roundedValues.reduce((value, max) => value > max ? value : max);

    double roundedMax = ((maxRoundedValue / 100).ceil() * 100).toDouble();
    double maxY = 0;
    if (roundedMax % 50000 == 0) {
      maxY = roundedMax;
    } else {
      int check = (roundedMax / 50000).toInt();
      check = check + 1;
      maxY = check * 50000;
    }
    if (maxY == 0) {
      maxY = 200000;
    }

    //for chart dont touch
    List<FlSpot> spots = List.generate(times.length, (index) {
      final time = times[index].millisecondsSinceEpoch.toDouble();

      return FlSpot(time, (powerValues[index] / 1e6).toInt().toDouble());
    });

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
                fitInsideHorizontally: true,
                tooltipBgColor: Colors.white,
                getTooltipItems: (List<LineBarSpot> touchTooltipData) {
                  return touchTooltipData.map((data) {
                    var date = DateTime.fromMillisecondsSinceEpoch(
                        data.x.toInt(),
                        isUtc: true);
                    String strDate = DateFormat('d MMM, yyyy, HH:mm')
                        .format(date)
                        .toString();
                    return LineTooltipItem(
                      (data.y / 1000).toStringAsFixed(3) +
                          ' PH/s' +
                          '\n' +
                          strDate,
                      TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
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

                return Text(
                  '${DateFormat('HH:mm').format(date).toString()}',
                  style: TextStyle(fontSize: 10, color: Colors.grey[400]),
                );
              },
            )),
            leftTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 25,
              interval: 50000,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString() + 'PH',
                  style: TextStyle(fontSize: 8, color: Colors.grey[500]),
                );
              },
            ))),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: false,
            color: AppColors().kPrimaryGreen,
            barWidth: 1.5,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
                show: true, color: AppColors().kPrimaryGreen.withOpacity(0.3)),
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
