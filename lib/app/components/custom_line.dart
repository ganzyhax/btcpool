import 'package:flutter/material.dart';

class TransparentLine extends StatelessWidget {
  final Color color;
  const TransparentLine({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 4, // Thickness of the line

      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color, // Solid color on one end
            color.withOpacity(0.5),
            Colors.transparent, // Transparent on the other end
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    ));
  }
}
