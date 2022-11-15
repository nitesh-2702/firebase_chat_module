import 'package:flutter/material.dart';

final String kAppId = "6321c574b9ef98263946ed4a";
final String kAppkey = "e6utaHu9ype7uqatytuvegyhuTyBy9eveYu4";

bool kTry = true;

var headerForVideoCall = (kTry)
    ? {
        "x-app-id": kAppId,
        "x-app-key": kAppkey,
        "Content-Type": "application/json"
      }
    : {"Content-Type": "application/json"};

class GetMessageProvider with ChangeNotifier {}
