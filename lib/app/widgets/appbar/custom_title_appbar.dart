import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTitleAppBar extends StatelessWidget {
  final String title;
  const CustomTitleAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      leading: Container(
        child: IconButton(
          icon: Icon(CupertinoIcons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
