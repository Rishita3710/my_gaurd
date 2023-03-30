import 'package:fluttertoast/fluttertoast.dart';

class ToastHelper {
  ToastHelper();

  static void showLongToast(String message) {
    Fluttertoast.showToast(msg: message);
  }
}
