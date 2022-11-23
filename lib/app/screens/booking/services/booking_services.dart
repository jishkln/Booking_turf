import 'package:dio/dio.dart';
import 'package:truff_majestic/app/core/services/api_endpoints.dart';
import 'package:truff_majestic/app/core/services/dio_error_exce.dart';
import 'package:truff_majestic/app/core/services/interseptor.dart';
import 'package:truff_majestic/app/screens/booking/model/booking_model.dart';

class BookingServices {
  BookingServices._instans();
  static BookingServices instance = BookingServices._instans();
  factory BookingServices() {
    return instance;
  }

  Future<BookingResponse?> getBookingList({required String id}) async {
    try {
      Dio dio = await InterceptorHelper().getApiClient();
      Response response = await dio
          .get(EndPoints.bookingDetail.replaceFirst("{id}", id.trim()));
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return BookingResponse.fromJson(response.data);
      }
    } on DioError catch (e) {
      final errorMsg = DioException.fromDioError(e).toString();
      BookingResponse(status: false, message: errorMsg);
    }

    return null;
  }
}
