import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:truff_majestic/app/screens/home/controller/home_view.dart';
import 'package:truff_majestic/app/screens/home/view/bottumNavi/user.dart';
import 'package:truff_majestic/app/screens/home/view/home.dart';
import 'package:truff_majestic/app/utils/constants/color_constants.dart';

import 'bottumNavi/widget/gg.dart';

class BottumNavi extends StatelessWidget {
  BottumNavi({super.key});
  final List pages = [
    const Home(),
    const ExampleParallax(),
    const UserData(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeViewProvider>(context);
    return Scaffold(
      body: pages[provider.currentIndexx],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 14,
        backgroundColor: buttonColor,
        selectedItemColor: backGrountColor,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 16,
        iconSize: 36,
        elevation: 10,
        landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
        selectedLabelStyle: GoogleFonts.robotoSlab(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          shadows: [
            const BoxShadow(
                color: Colors.black12,
                offset: Offset(1, 1),
                blurRadius: 2,
                spreadRadius: 1,
                blurStyle: BlurStyle.outer)
          ],
        ),
        unselectedLabelStyle: GoogleFonts.robotoSlab(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            shadows: [
              const BoxShadow(
                  color: Colors.white10,
                  offset: Offset(1, 1),
                  blurRadius: 2,
                  spreadRadius: 1,
                  blurStyle: BlurStyle.outer)
            ]),
        unselectedIconTheme: const IconThemeData(
          color: blackColor,
          size: 28,
          shadows: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(1, 1),
              color: Colors.cyanAccent,
            ),
          ],
        ),
        currentIndex: provider.currentIndexx,
        onTap: (index) => provider.bottomNaviState = index,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports),
            label: 'Sports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
      ),
    );
  }
}
