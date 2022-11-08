import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truff_majestic/app/screens/splash/controller/splashprovider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashProvider>().init();
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: const Center(
        child: Text("Splash "),
      ),
    );
  }
}
