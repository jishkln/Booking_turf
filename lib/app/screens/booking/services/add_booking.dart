import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:truff_majestic/app/core/services/api_endpoints.dart';
import 'package:truff_majestic/app/core/services/dio_error_exce.dart';
import 'package:truff_majestic/app/core/services/interseptor.dart';

class BookingServiceAdd {
  BookingServiceAdd._instans();
  static BookingServiceAdd instance = BookingServiceAdd._instans();
  factory BookingServiceAdd() {
    return instance;
  }

  Future<bool> book(value) async {
    try {
      Dio dio = await InterceptorHelper().getApiClient();
      Response response =
          await dio.post(EndPoints.bookTurf, data: value.toJson());
      if (response.statusCode == 200) {
        // print(response.data);
        log("service${response.data}");
        return true;
      }
    } on DioError catch (e) {
      final errorMsg = DioException.fromDioError(e).toString();

      Fluttertoast.showToast(msg: errorMsg);
    }
    return false;
  }
}
