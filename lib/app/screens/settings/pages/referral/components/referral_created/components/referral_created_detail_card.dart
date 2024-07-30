import 'package:easy_localization/easy_localization.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';

class ReferralCreatedInfoCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool? withImage;
  final String? additionalSubTitle;

  const ReferralCreatedInfoCard(
      {super.key,
      required this.title,
      required this.subTitle,
      this.withImage,
      this.additionalSubTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.secondary),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: AppColors().kPrimaryGrey, fontSize: 17),
          ).tr(),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  (withImage == true)
                      ? SizedBox(
                          height: 45,
                          child: Image.asset('assets/images/btc_logo.png'),
                        )
                      : const SizedBox(),
                  SizedBox(width: (withImage == true) ? 10 : 0),
                  Row(
                    children: [
                      Text(
                        subTitle,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      (additionalSubTitle != null)
                          ? Text(
                              additionalSubTitle.toString(),
                              style: TextStyle(
                                  color: AppColors().kPrimaryGrey,
                                  fontSize: 19),
                            )
                          : const SizedBox()
                    ],
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      ),
    );
  }
}
