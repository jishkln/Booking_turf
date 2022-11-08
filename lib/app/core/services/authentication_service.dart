import 'package:dio/dio.dart';
import 'package:truff_majestic/app/core/services/api_endpoints.dart';
import 'package:truff_majestic/app/core/services/dio_error_exce.dart';
import 'package:truff_majestic/app/screens/auth/login_page/model/login_model.dart';
import 'package:truff_majestic/app/screens/auth/login_page/model/numberlogin.dart';
import 'package:truff_majestic/app/screens/auth/signup_page/model/signup_model.dart';

class AuthenticationService {
  final Dio _dio = Dio(BaseOptions(baseUrl: EndPoints.baseUrl));

//============Email Login=============

  Future<EmailLoginRespones?> loginEmail(EmailLoginM emailLoginM) async {
    try {
      Response response =
          await _dio.post(EndPoints.loginEmail, data: emailLoginM.toJson());
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return EmailLoginRespones.fromJson(response.data);
      }
    } on DioError catch (e) {
      final errorMesg = DioException.fromDioError(e).toString();
      //Fluttertoast.showToast(msg: errorMesg);
      return EmailLoginRespones(error: false, message: errorMesg);
    }
    return null;
  }

  //===============Email SignUp==================

  Future<EmailSignupResponceM?> emailSignup(EmailSignupM emailSignupM) async {
    try {
      Response response =
          await _dio.post(EndPoints.signupEmail, data: emailSignupM.toJson());
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return EmailSignupResponceM.fromJson(response.data);
      }
    } on DioError catch (e) {
      final errorMesg = DioException.fromDioError(e).toString();
      //Fluttertoast.showToast(msg: errorMesg);
      return EmailSignupResponceM(error: false, message: errorMesg);
    }
    return null;
  }

  //==================Email SignUp Otp=================
  Future<EmailOtpResponceM?> verifyEmailOtp(EmailOtpM emailOtpM) async {
    try {
      Response response =
          await _dio.post(EndPoints.verifyEmail, data: emailOtpM.toJson());
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return EmailOtpResponceM.fromJson(response.data);
      }
    } on DioError catch (e) {
      final errorMesg = DioException.fromDioError(e).toString();
      // Fluttertoast.showToast(msg: errorMesg);
      return EmailOtpResponceM(error: false, message: errorMesg);
    }
    return null;
  }

  //=========================Login Phone=======================

  Future<LoginNumberResponesM?> loginPhone(PhoneNumberM phoneNumberM) async {
    try {
      Response response =
          await _dio.post(EndPoints.loginPhone, data: phoneNumberM.toJson());
      // log(response.data.toString());
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return LoginNumberResponesM.fromJson(response.data);
      }
    } on DioError catch (e) {
      final errorMesg = DioException.fromDioError(e).toString();
      //Fluttertoast.showToast(msg: errorMesg);
      return LoginNumberResponesM(error: false, message: errorMesg);
    }
    return null;
  }

//=======================verify phone Otp===================

  Future<LoginNumberOtpResponesM?> verifyNumberOtp(
      PhoneNumberVerifyM phoneNumberVerifyM) async {
    try {
      Response response = await _dio.post(EndPoints.verifyPhone,
          data: phoneNumberVerifyM.toJson());
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return LoginNumberOtpResponesM.fromJson(response.data);
      }
    } on DioError catch (e) {
      final errorMesg = DioException.fromDioError(e).toString();
      //Fluttertoast.showToast(msg: errorMesg);

      return LoginNumberOtpResponesM(error: false, message: errorMesg);
    }
    return null;
  }
}
