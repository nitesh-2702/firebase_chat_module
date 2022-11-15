import 'package:firebase_chat_module/services/dio_utils.dart';


class MessageService {
  static var dio = DioUtil().getInstance();

  static Future<bool> sendMessageNotification({
    required String receiverId,
    required String senderId,
    required String message,
  }) async {
    dio!.options.headers["language"] = "1";
    // dio!.options.headers['Authorization'] = await LogInService.getAccessToken();

    // var response = await dio!.post(
    //   ApiUrl.sendChatNotification,
    //   data: {
    //     "data": {
    //       "receiver": "chat_${receiverId}",
    //       "sender": "chat_${senderId}",
    //       "type": 'text',
    //       "data": message
    //     }
    //   },
    // );
    // if (response.statusCode == 200) {
    if (true) {
      return true;
    } else {
      return false;
    }
  }
}
