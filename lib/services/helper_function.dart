import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_chat_module/services/dio_utils.dart';

class HelperFunction {
  static final _dioInstance = DioUtil().getInstance();

  static Future<String?> uploadSingleImageFileChat(String imagePath,
      String userId, String fileName, String mediaType) async {
    if (imagePath.contains('http')) {
      return imagePath;
    }
    try {
      String fileName = imagePath.split('/').last;
      final tempvalue =
          await MultipartFile.fromFile(imagePath, filename: fileName);

      FormData formData = FormData.fromMap({
        "file": tempvalue,
      });
      ///Add your API URL here.
      var apiPath = "";
      var response = await _dioInstance?.post(apiPath, data: formData);
      var imageData = response?.data;
      
      return imageData['result'];
    } catch (err) {
      log("error on image upload s3: $err");
      return null;
    }
  }
}
