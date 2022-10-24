import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truff_majestic/app/screens/auth/login_page/view/login_email.dart';
import 'package:truff_majestic/app/screens/pages/auth/signup_page/controller/signup_provider.dart';
import 'package:truff_majestic/app/screens/shared/themes.dart';

import 'app/screens/auth/login_page/controller/login_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = TurffTheme.light();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SignupProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Turff-Majesty',
        theme: theme,
        home: const LoginEmail(),
      ),
    );
  }
}
