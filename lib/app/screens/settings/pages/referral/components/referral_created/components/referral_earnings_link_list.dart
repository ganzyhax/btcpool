import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:btcpool_app/app/screens/settings/pages/referral/components/referral_created/components/referral_earnings_link_card.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class ReferralEarningsLinkList extends StatefulWidget {
  final List data;

  const ReferralEarningsLinkList({Key? key, required this.data})
      : super(key: key);

  @override
  _ReferralEarningsLinkListState createState() =>
      _ReferralEarningsLinkListState();
}

class _ReferralEarningsLinkListState extends State<ReferralEarningsLinkList> {
  int _visibleItemCount = 7;
  late List _displayedData;

  @override
  void initState() {
    super.initState();
    widget.data.sort((a, b) {
      // Convert earnings_for_str strings to DateTime objects
      DateTime dateTimeA = DateTime.parse(a['earnings_for_str']);
      DateTime dateTimeB = DateTime.parse(b['earnings_for_str']);
      // Compare DateTime objects to sort in ascending order
      return dateTimeB.compareTo(dateTimeA);
    });
    if (widget.data.length > _visibleItemCount) {
      _displayedData = widget.data.sublist(0, _visibleItemCount);
    } else {
      _displayedData = widget.data.sublist(0, widget.data.length);
    }
    // Initial displayed data
  }

  void _loadMoreItems() {
    setState(() {
      if (widget.data.length ~/ _displayedData.length == 1) {
        _visibleItemCount +=
            (widget.data.length % _displayedData.length).toInt();
      } else {
        _visibleItemCount += 7;
      }
      _displayedData =
          widget.data.sublist(0, _visibleItemCount); // Update displayed data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    child: Text(
                      LocaleKeys.date.tr(),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    child: Text(
                      LocaleKeys.hashrate_24h.tr(),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 7,
                    child: Text(
                      LocaleKeys.total_income.tr(),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 7,
                    child: Text(
                      LocaleKeys.referral_user.tr(),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        (widget.data.isNotEmpty)
            ? Column(
                children: _displayedData.map<Widget>((e) {
                  return ReferralEarningsLinkCard(data: e);
                }).toList(),
              )
            : const SizedBox(),
        if (_displayedData.length !=
            widget.data
                .length) // Display "Load More" button if all items have not been displayed
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.5,
            child: CustomButton(
              text: LocaleKeys.load_more.tr(),
              function: _loadMoreItems,
            ),
          ),
      ],
    );
  }
}
