import 'package:btcpool_app/app/widgets/subaccount_card.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final bool? withSubAccount;
  final bool? withArrow;

  const CustomAppBar(
      {super.key,
      this.title,
      this.withSubAccount = true,
      this.withArrow = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: (withArrow == true) ? true : false,
      title: (title == null)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100,
                  child: Image.asset('assets/images/btcpool_logo.png'),
                ),
                SubAccountCard()
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                (withSubAccount == true) ? SubAccountCard() : SizedBox()
              ],
            ),
    );
  }
}
