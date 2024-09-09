import 'package:btcpool_app/app/views/settings/components/settings_item_icon_card.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String asset;
  final String text;
  final Function()? function;
  const SettingsItem(
      {super.key, required this.asset, required this.text, this.function});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (function != null) ? function : null,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).colorScheme.secondary),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    SettingsItemIconCard(
                      asset: asset,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      text,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: 18,
              )
            ],
          ),
        ),
      ),
    );
  }
}
