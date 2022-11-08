import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truff_majestic/app/screens/auth/signup_page/controller/signup_provider.dart';
import 'package:truff_majestic/app/screens/home/controller/home_view.dart';
import 'package:truff_majestic/app/screens/home/controller/geolocator.dart';
import 'package:truff_majestic/app/screens/home/view/bottumNavi/widget/controller.dart';
import 'package:truff_majestic/app/screens/shared/themes.dart';
import 'package:truff_majestic/app/screens/splash/controller/splashprovider.dart';
import 'package:truff_majestic/app/screens/splash/view/splash.dart';
import 'package:truff_majestic/app/utils/navigation.dart';

import 'app/screens/auth/login_page/controller/login_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // LocationProvider().getCurrerntPosition(context);

    final theme = TurffTheme.light();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CoustomScrollProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SplashProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeViewProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SignupProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationProvider(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: NavigationServices.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Turff-Majesty',
        theme: theme,
        home: const SplashScreen(),
      ),
    );
  }
}
