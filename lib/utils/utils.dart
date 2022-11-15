import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';


class Utilities {
  ///Getting Device ID HERE
  Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      // unique ID on Android
      print(androidDeviceInfo.id);
      return androidDeviceInfo.id;
    }
    return '';
  }

  ///Getting Device Token HERE
  String getDeviceToken() {
    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      return token;
    });
    return '';
  }

  ///Converts microsecondsSinceEpoch to only Date and Time
  String dateTimeConvertor(
      {required DateTime date, bool? onlyTime, bool? onlyDate}) {
    DateTime dateTime = (date);
    if (onlyTime ?? false) {
      ///Returns the time in 12 hour format.
      return DateFormat.jm().format(dateTime).toString();
    }
    if (onlyDate ?? false) {
      ///Currently it is US based Date Month/date/Year
      return DateFormat('yMd').format(dateTime).toString();
    }
    return dateTime.toString();
  }
}
