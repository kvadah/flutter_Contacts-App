import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void showToast(String message, {ToastGravity gravity = ToastGravity.BOTTOM, Color bgColor = Colors.white, Color textColor = Colors.red}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: gravity, // Position of the toast
    backgroundColor: bgColor,
    textColor: textColor,
    fontSize: 16.0,
  );
}
