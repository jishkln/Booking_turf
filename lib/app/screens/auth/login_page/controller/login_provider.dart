// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:truff_majestic/app/core/services/authentication_service.dart';
import 'package:truff_majestic/app/screens/auth/login_page/model/login_model.dart';
import 'package:truff_majestic/app/screens/auth/login_page/model/numberlogin.dart';
import 'package:truff_majestic/app/screens/auth/login_page/view/phone_pin.dart';
import 'package:truff_majestic/app/screens/home/home.dart'; 

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isEmail = true;
  bool otpVerify = false;
  bool isPassVisible = true;
  final dataStorage = const FlutterSecureStorage();

  final formKeyEmail = GlobalKey<FormState>();

  final formKeyPhone = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneControlller = TextEditingController();
  final otpPhoneController = TextEditingController();

  void visiblePass() {
    isPassVisible = !isPassVisible;
    notifyListeners();
  }

  //=============emaiLogin===============

  void emailLogin(BuildContext context, [bool mountted = true]) async {

    
    isLoading = true;
    notifyListeners();
    if (!formKeyEmail.currentState!.validate()) {
      isLoading = false;
      notifyListeners();
      return;
    }
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: "enter valid email or password");
      return;
    }
    EmailLoginRespones? response = await AuthenticationService()
        .loginEmail(EmailLoginM(email: email, passwrd: password));

    if (response!.error == true) {
      dataStorage.write(key: "refreshToken", value: response.refreshToken);
      dataStorage.write(key: "token", value: response.token);
      dataStorage.write(key: "login", value: "true");
      await dataStorage.write(key: "id", value: response.id.toString());
      

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: ((context) => const Home()),
        ),
      );
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: response.message.toString());
    }
  }

  //====================Phonenumber Login============================

  void phoneLogin(BuildContext context) async {
    isEmail = true;
    isLoading = true;
    notifyListeners();
    int? numbr = int.parse(phoneControlller.text);
    log("Login provider Phone $numbr");
    if (!formKeyPhone.currentState!.validate()) {
      isLoading = false;
      notifyListeners();
      return;
    }
    if (phoneControlller.text.toString().length != 10) {
      Fluttertoast.showToast(msg: "phone number not valid");
      isLoading = false;
      notifyListeners();
      return;
    }

    LoginNumberResponesM? response =
        await AuthenticationService().loginPhone(PhoneNumberM(number: numbr));

    if (response?.status == true) {
      await dataStorage.write(key: "id", value: response?.id ?? '');
      await dataStorage.write(key: "user_number", value: numbr.toString());
      Fluttertoast.showToast(msg: response?.message ?? 'Done Sucesss');
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OtpPhone(),
          ));

      isLoading = false;
      otpVerify = true;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(
        msg: response?.message ?? "Error",
        backgroundColor: Colors.red,
      );
    }
  }

  //========================phone Otp Verify==========================
  void phoneOtpVerify(BuildContext context, pin) async {
    isLoading = true;
    isEmail = false;
    notifyListeners();
    int? number = int.parse(phoneControlller.text);
    String? id = await dataStorage.read(key: "id");
    if (!formKeyPhone.currentState!.validate()) {
      isLoading = false;
      notifyListeners();
      return;
    }
    PhoneNumberVerifyM data = PhoneNumberVerifyM(
      id: id,
      userNumber: number,
      userOtp: phoneControlller.text,
    );
    LoginNumberOtpResponesM? response =
        await AuthenticationService().verifyNumberOtp(data);

    if (response?.status == true) {
      dataStorage.write(key: "refreshToken", value: response!.refreshToken);
      dataStorage.write(key: "token", value: response.token);
      //navi
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ));

      dataStorage.write(key: "login", value: "true");
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
    }
  }
}
