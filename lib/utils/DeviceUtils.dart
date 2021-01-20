import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeviceUtils {
  static Future<bool> haveInternectConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  static void presentToast(String text, ScaffoldState scaffold) {
    scaffold.showSnackBar(SnackBar(content: Text(text)));
  }

  static Future<PhoneContact> pickContact() async {
    return await FlutterContactPicker.pickPhoneContact(askForPermission: true);
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }
}
