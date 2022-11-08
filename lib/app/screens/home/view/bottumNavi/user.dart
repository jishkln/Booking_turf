import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:truff_majestic/app/screens/auth/login_page/view/login_email.dart';
import 'package:truff_majestic/app/utils/navigation.dart';

class UserData extends StatelessWidget {
  const UserData({super.key});

  @override
  Widget build(BuildContext context) {
    const storage = FlutterSecureStorage();
    return Center(
      child: IconButton(
          onPressed: () async {
            await storage.deleteAll();

            NavigationServices.pushRemoveUntil(screen: const LoginEmail());
          },
          icon: const Icon(Icons.logout)),
    );
  }
}
