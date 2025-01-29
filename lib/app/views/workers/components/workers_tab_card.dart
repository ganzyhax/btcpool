import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WorkersTabCard extends StatelessWidget {
  final String title;
  final String data;
  final bool isSelected;
  final Color color;
  const WorkersTabCard(
      {super.key,
      required this.title,
      required this.data,
      required this.isSelected,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 7, bottom: 7),
      decoration: BoxDecoration(
          color: (isSelected) ? color : Colors.white.withOpacity(0),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color)),
      child: Center(
          child: Row(
        children: [
          Text(
            title,
            style: TextStyle(color: (isSelected) ? Colors.white : color),
          ).tr(),
          Text(
            ' ' + data,
            style: TextStyle(color: (isSelected) ? Colors.white : color),
          ),
        ],
      )),
    );
  }
}
