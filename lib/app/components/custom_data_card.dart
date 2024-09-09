import 'package:btcpool_app/local_data/const.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDataCard extends StatelessWidget {
  final String title;
  final String data;
  final String? urlOpen;
  const CustomDataCard(
      {super.key, required this.title, required this.data, this.urlOpen});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: TextStyle(color: AppColors().kPrimaryGrey, fontSize: 14),
        ),
        (urlOpen != null)
            ? InkWell(
                onTap: () async {
                  if (await canLaunch(urlOpen.toString())) {
                    await launch(urlOpen.toString());
                  } else {}
                },
                child: Text(
                  data,
                  style: const TextStyle(color: Colors.blue, fontSize: 16),
                ),
              )
            : Text(
                data,
                style: const TextStyle(fontSize: 16),
              )
      ]),
    );
  }
}
