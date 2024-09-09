import 'package:btcpool_app/app/components/custom_indicator.dart';
import 'package:btcpool_app/local_data/const.dart';

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? function;
  final bool? isLoading;
  final bool? isEnable;
  final Color? color;

  const CustomButton(
      {super.key,
      required this.text,
      this.color,
      this.function,
      this.isEnable = true,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (isEnable == true) ? function : null,
      child: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: (color == null)
              ? (isEnable == true)
                  ? AppColors().kPrimaryGreen
                  : AppColors().kPrimaryGreen.withOpacity(0.5)
              : (isEnable == true)
                  ? color
                  : color!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
            child: (isLoading == false)
                ? Text(
                    text,
                    style: TextStyle(
                        color: (color != null)
                            ? (color == Colors.white)
                                ? Colors.black
                                : Colors.white
                            : Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  )
                : CustomIndicator(
                    size: 24,
                    isWhite: true,
                  )),
      ),
    );
  }
}
