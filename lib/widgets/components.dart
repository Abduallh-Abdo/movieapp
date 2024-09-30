import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> defaultToast({
  required msg,
  required ToastStates state,
}) async {
  return await Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: changeToastState(state: state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastStates {
  success,
  error,
  warning,
}

Color changeToastState({required ToastStates state}) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.lightGreen;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}
