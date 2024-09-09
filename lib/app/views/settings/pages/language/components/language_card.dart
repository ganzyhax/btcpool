import 'package:flutter/material.dart';
import 'package:btcpool_app/local_data/const.dart';

class LanguageCard extends StatelessWidget {
  final String title;
  final String asset;
  final Function() function;
  final bool isSelected;
  const LanguageCard(
      {super.key,
      required this.title,
      required this.function,
      required this.asset,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(
                color: (isSelected == true)
                    ? AppColors().kPrimaryGreen
                    : Colors.white,
                width: (isSelected == true) ? 1 : 0),
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).colorScheme.secondary),
        child: Row(
          children: [
            Image.asset(
              asset,
              width: 40,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
