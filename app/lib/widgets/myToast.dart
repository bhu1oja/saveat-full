import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

// myToast(String toast) {
//   return Fluttertoast.showToast(
//       msg: toast,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIos: 1,
//       backgroundColor: Colors.red,
//       textColor: Colors.white);
// }

myToast(String toast, context) {
  Toast.show(toast, context,
      backgroundColor: Colors.green,
      backgroundRadius: 8,
      duration: Toast.LENGTH_SHORT,
      gravity: Toast.BOTTOM);
}
