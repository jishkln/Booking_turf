import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:truff_majestic/app/screens/auth/login_page/view/login_email.dart';
import 'package:truff_majestic/app/screens/home/view/bottumnav.dart';

import 'package:truff_majestic/app/utils/navigation.dart';

class SplashProvider extends ChangeNotifier {
  Future<void> init() async {
    const dataStorage = FlutterSecureStorage();
    String? value = await dataStorage.read(key: 'login');
    Timer(const Duration(seconds: 4), () {
      if (value != null) {
        NavigationServices.pushreplace(
          screen: BottumNavi(),
        );
      } else {
        NavigationServices.pushreplace(screen: const LoginEmail());
      }
    });
  }
}
