import 'package:btcpool_app/local_data/const.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomIndicator extends StatelessWidget {
  final bool? isWhite;
  final double? size;
  const CustomIndicator({super.key, this.isWhite, this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (size == null) ? 40 : size,
      width: (size == null) ? 40 : size,
      child: LoadingIndicator(
        indicatorType: Indicator.lineScale,
        colors: (isWhite == true)
            ? [AppColors().kPrimaryWhite]
            : [AppColors().kPrimaryGreen],
        strokeWidth: 2,
        pathBackgroundColor: Colors.black,
        backgroundColor: Colors.black.withOpacity(0),
      ),
    );
  }
}
