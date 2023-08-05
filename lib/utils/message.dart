import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> message(String message, bool isSuccess) async {
  Fluttertoast.showToast(
    gravity: ToastGravity.BOTTOM,
      msg: message,
      textColor: Colors.white,
      backgroundColor: isSuccess ? Colors.green : Colors.red);
}
