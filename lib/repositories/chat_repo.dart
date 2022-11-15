
import 'package:firebase_chat_module/models/video_call_modal.dart';
import 'package:firebase_chat_module/services/dio_utils.dart';

class ChatRepository {
  var _dioInstance = DioUtil().getInstance();

  Future<VideoCallModel> getVideoCallToken(String callerId, String callerName,
      String receiverID, String callType) async {
    var body = {
      "callerId": callerId,
      "recieverId": receiverID,
      "callerName": callerName,
      "callType": callType
    };
    ///Add your Video Call API URL HERE
    var response = await _dioInstance?.post(
      "",
      data: body,
    );
    var responseData = response!.data;
    return VideoCallModel.fromJson(responseData);
  }
}
