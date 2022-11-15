import 'dart:convert';

VideoCallModel videoCallModelFromJson(String str) =>
    VideoCallModel.fromJson(json.decode(str));

String videoCallModelToJson(VideoCallModel data) => json.encode(data.toJson());

class VideoCallModel {
  VideoCallModel({
    this.status,
    this.roomId,
    this.token,
    this.tokenMobile,
  });

  bool? status;
  String? roomId;
  String? token;
  TokenMobile? tokenMobile;

  factory VideoCallModel.fromJson(Map<String, dynamic> json) => VideoCallModel(
        status: json["status"],
        roomId: json["roomId"],
        token: json["token"],
        tokenMobile: TokenMobile.fromJson(json["tokenMobile"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "roomId": roomId,
        "token": token,
        "tokenMobile": tokenMobile!.toJson(),
      };
}

class TokenMobile {
  TokenMobile({
    required this.result,
    required this.token,
  });

  int result;
  String token;

  factory TokenMobile.fromJson(Map<String, dynamic> json) => TokenMobile(
        result: json["result"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "token": token,
      };
}
