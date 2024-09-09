import 'package:btcpool_app/local_data/const.dart';
import 'package:flutter/material.dart';

class CustomSnackbar {
  void showCustomSnackbar(BuildContext context, String message, bool isMessage,
      {String actionLabel = '', VoidCallback? onAction}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      backgroundColor:
          (isMessage == true) ? AppColors().kPrimaryGreen : Colors.red,
      duration: Duration(seconds: 3),
      action: (actionLabel.isNotEmpty && onAction != null)
          ? SnackBarAction(
              label: actionLabel,
              textColor: Colors.yellow,
              onPressed: onAction,
            )
          : null,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
