import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void showToast(String message,
    {ToastGravity gravity = ToastGravity.BOTTOM,
    Color bgColor = Colors.white,
    Color textColor = Colors.red}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: gravity, // Position of the toast
    backgroundColor: bgColor,
    textColor: textColor,
    fontSize: 16.0,
  );
}

Future<bool> showCancelDialog({
  required BuildContext context,
  required String title,
  required String content,
}) async {
  return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Yes'),
              ),
            ],
          );
        },
      ) ??
      false;
}
