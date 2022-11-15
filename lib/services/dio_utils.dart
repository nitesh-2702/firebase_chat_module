import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_chat_module/utils/constants.dart';
import 'package:firebase_chat_module/utils/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioUtil {
  Dio? _instance;
  Dio? getInstance() {
    _instance ??= createDioInstance();
    return _instance;
  }

  Dio createDioInstance() {
    var dio = Dio();
    dio.interceptors.clear();
    return dio
      ..interceptors
          .add(InterceptorsWrapper(onRequest: (options, handler) async {
        // final prefs = await SharedPreferences.getInstance();
        final prefs = getIt<SharedPreferences>();
        // var accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7Il9pZCI6IjYzMWFkNWIwYjFjODI2NmI2ZjY0Nzk0MyIsImVtYWlsIjoibmlrZUBnbWFpbC5jb20ifSwiaWF0IjoxNjYzMTI5ODM1LCJleHAiOjE2NjMxMzcwMzV9.zJzmt6xPj4-dRo6EL2WtGj47o71OeT_Anbc8wB9GOTg";
        final accessToken = prefs.getString(PrefConstants.accessToken);
        options.headers["x-access-Token"] = "$accessToken";

        return handler.next(options); //modify your request
      }, onResponse: (response, handler) {
        if (response != null) {
          return handler.next(response);
        } else {
          return handler.next(response);
        }
      }, onError: (DioError e, handler) async {
        log('dio error: ' + e.toString());
        if (e.response != null) {
          handler.resolve(e.response!);
        }
      }));
  }
}
