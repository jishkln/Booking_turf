import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:truff_majestic/app/core/services/api_endpoints.dart';
import 'package:truff_majestic/app/core/services/dio_error_exce.dart';
import 'package:truff_majestic/app/screens/home/model/home_model.dart';

class HomeServises {
  final Dio _dio = Dio(BaseOptions(baseUrl: EndPoints.baseUrl));
  final dataStorage = const FlutterSecureStorage();

  Future<HomeResponse?> getNearTurf(String place, String token) async {
    try {
      final String? token = await dataStorage.read(key: "token");
      Response response = await _dio.get(EndPoints.nearByTruf + place,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode! >= 200 || response.statusCode! <= 299) {
        return HomeResponse.fromJson(response.data);
      }
    } on DioError catch (e) {
      final errorMsg = DioException.fromDioError(e).toString();
      log("NearBy Service:${errorMsg.toString()}");
      return HomeResponse(status: false, message: errorMsg);
    }
    return null;
  }

  







}
