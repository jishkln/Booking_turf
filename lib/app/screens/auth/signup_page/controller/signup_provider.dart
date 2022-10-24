// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:truff_majestic/app/core/services/authentication_service.dart';
import 'package:truff_majestic/app/screens/auth/login_page/view/pin_put.dart';
import 'package:truff_majestic/app/screens/home/home.dart';
import 'package:truff_majestic/app/screens/pages/auth/signup_page/model/signup_model.dart';

class SignupProvider extends ChangeNotifier {
  bool isEmail = true;
  bool isLoading = false;
  bool otpVerify = false;
  bool isPassVisible = true;
  final dataStorage = const FlutterSecureStorage();

  final signupKey = GlobalKey<FormState>();
  final formKeyEmailOtp = GlobalKey<FormState>();
  final enamilController = TextEditingController();
  final enamilOtpController = TextEditingController();
  final passwordControlller = TextEditingController();
  final conformPassword = TextEditingController();

  void visiblePass() {
    isPassVisible = !isPassVisible;
    notifyListeners();
  }

//========================email verification==========================
  void emailVerify(BuildContext context) async {
    isEmail = true;
    isLoading = true;
    notifyListeners();
    if (!signupKey.currentState!.validate()) {
      isLoading = false;
      notifyListeners();
      return;
    }

    String email = enamilController.text.trim();
    String passwrd = passwordControlller.text.trim();
    String conPass = conformPassword.text.trim();
    if (passwrd != conPass) {
      Fluttertoast.showToast(msg: "password not match");
    }

    EmailSignupResponceM? responce = await AuthenticationService()
        .emailSignup(EmailSignupM(email: email, passwrd: passwrd));
    if (responce != null) {
      await dataStorage.write(key: "id", value: responce.id);
      if (responce.error == true) {
        Fluttertoast.showToast(msg: responce.message.toString());
        // Routes.pushreplace(screen: const Otp());
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Otp(
                    isEmail: isEmail,
                  )),
        );
        // Get.to(() => const Otp());
        isLoading = true;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(msg: responce.message.toString());
      }
    } else {
      isLoading = false;
      notifyListeners();
    }
  }

  void verifyEmailOtp(BuildContext context, pin) async {
    isLoading = true;
    otpVerify = false;
    notifyListeners();

    String? id = await dataStorage.read(key: "id");
    EmailOtpResponceM? response = await AuthenticationService()
        .verifyEmailOtp(EmailOtpM(id: id, otp: pin));
    if (response!.error == true) {
      dataStorage.write(key: "refreshToken", value: response.refreshTocken);
      dataStorage.write(key: "token", value: response.token);
      dataStorage.write(key: "login", value: "true");
      dataStorage.write(key: "id", value: response.id.toString());
      //  Get.to(() => const Home());

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
      // Routes.pushRemoveUntil(screen: const Home());
      isLoading = false;

      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: response.message.toString());
      isLoading = false;
      notifyListeners();
    }
  }
}
