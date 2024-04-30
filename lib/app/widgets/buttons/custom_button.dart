import 'package:btcpool_app/app/widgets/custom_indicator.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? function;
  final bool? isLoading;
  final bool? isEnable;
  const CustomButton(
      {super.key,
      required this.text,
      this.function,
      this.isEnable = true,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (isEnable == true) ? function : null,
      child: Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: (isEnable == true)
              ? AppColors().kPrimaryGreen
              : AppColors().kPrimaryGreen.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
            child: (isLoading == false)
                ? Text(
                    text,
                    style: TextStyle(
                        color: AppColors().kPrimaryWhite,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  )
                : CustomIndicator(
                    size: 25,
                    isWhite: true,
                  )),
      ),
    );
  }
}
