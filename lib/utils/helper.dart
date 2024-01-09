import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

String convertToDateTime(int dt) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dt * 1000);

  return '${dateTime.month}/${dateTime.day}/${dateTime.year}  ${dateTime.hour}:${dateTime.minute}';
}

toast(message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

bool isEmail(String email) {
  RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

  return emailRegex.hasMatch(email);
}
