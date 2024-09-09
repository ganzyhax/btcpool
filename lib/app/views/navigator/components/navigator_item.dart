import 'package:btcpool_app/app/views/navigator/components/gradient_icon.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:flutter/material.dart';

class NavigationItem extends StatelessWidget {
  final String assetImage;
  final bool isSelected;
  final String text;
  const NavigationItem(
      {super.key,
      required this.assetImage,
      required this.isSelected,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GradientSvgIcon(
          isSelected: isSelected,
          assetName: assetImage, // Path to your SVG file
          size: 22.0, // Adjust the size as needed
        ),
        SizedBox(
          height: 5,
        ),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (Rect bounds) => (isSelected)
              ? AppColors().kPrimaryGradientGreenColor.createShader(bounds)
              : AppColors().kPrimaryGradientGrey.createShader(bounds),
          child:
              Text(text, style: TextStyle(color: Colors.white, fontSize: 12)),
        ),
      ],
    );
  }
}
