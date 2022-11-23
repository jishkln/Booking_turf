import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:truff_majestic/app/core/services/api_endpoints.dart';
import 'package:truff_majestic/app/core/services/dio_error_exce.dart';

class InterceptorHelper {
  FlutterSecureStorage dataStorage = const FlutterSecureStorage();
  
  Dio dio = Dio(BaseOptions(baseUrl: EndPoints.baseUrl));
  Future<Dio> getApiClient() async {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: ((response, handler) async {
          final token = await getTocken();
          response.headers.addAll({"Authorization": "Bearer $token"});
          return handler.next(response);
        }),
        onError: (e, handler) async {
          if (e.response?.statusCode == 403) {
            final refreshToken = await getRefreshToken();
            log("InterceptorHelper refreshToken:$refreshToken");
            try {
              await dio.post('account/refresh-token',
                  data: {'refreshToken': refreshToken}).then((value) async {
                if (value.statusCode == 200) {
                  final tcnData = value.data["token"];
                  await saveToSorage(tcnData);
                  e.requestOptions.headers
                      .addAll({"Authorization": "Bearer $tcnData"});
                  final option = Options(
                      method: e.requestOptions.path,
                      headers: e.requestOptions.headers);
                  final mergeRequest = await dio.request(e.requestOptions.path,
                      options: option,
                      data: e.requestOptions.data,
                      queryParameters: e.requestOptions.queryParameters);
                  return handler.resolve(mergeRequest);
                }
                return handler.next(e);
              });
            } on DioError catch (e) {
              final errMsg = DioException.fromDioError(e).toString();
              Fluttertoast.showToast(msg: errMsg);
            }
          }
        },
      ),
    );
    return dio;
  }

  Future<String> getTocken() async {
    return await dataStorage.read(key: "token") ?? "";
  }

  Future<String> getRefreshToken() async {
    return await dataStorage.read(key: "refreshToken") ?? "";
  }

  Future<void> saveToSorage(String data) async {
    await dataStorage.write(key: "token", value: data);
  }
}
