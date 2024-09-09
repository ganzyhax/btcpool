import 'package:btcpool_app/app/views/navigator/components/gradient_icon.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingsItemIconCard extends StatelessWidget {
  final String asset;

  SettingsItemIconCard({
    super.key,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SvgPicture.asset(
          asset,
          color: AppColors().kPrimaryGreen,
        ),
      ),
      decoration: BoxDecoration(
          color: AppColors().kPrimaryGreen.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(
        10,
      ),
    );
  }
}
