import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as ft;
import 'package:toast/toast.dart';

void showToast(String mes, BuildContext context, {bool isSuccess = false}) {
  if (mes == null || mes.trim() == '') return;
  Toast.show(
    mes,
    context,
    duration: mes.length > 40 ? 5 : 3,
    gravity: Toast.TOP,
    backgroundColor: isSuccess
        ? Colors.green.withOpacity(0.85)
        : Colors.red.withOpacity(0.85),
  );
}

Future showToastNoContext(String mes) async {
  await ft.Fluttertoast.cancel();
  return ft.Fluttertoast.showToast(
      fontSize: 14,
      msg: mes,
      toastLength: ft.Toast.LENGTH_SHORT,
      gravity: ft.ToastGravity.TOP,
      backgroundColor: Colors.deepOrange.withOpacity(0.85),
      textColor: Colors.white);
}
