import 'package:flutter/material.dart';
import 'package:truff_majestic/app/screens/shared/themes.dart';
import 'package:truff_majestic/app/utils/constants/color_constants.dart';
import 'package:truff_majestic/app/utils/constants/images.dart';
import 'package:truff_majestic/app/utils/constants/size_constants.dart';
 

class CoustemCard extends StatelessWidget {
  const CoustemCard({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 30, 20, 20),
      padding: const EdgeInsets.only(top: 30),
      width: size.width,
      height: size.height / 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backGrountColor,
        boxShadow: const [
          BoxShadow(color: subTextColor, blurRadius: 15, spreadRadius: 1)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Image.asset(
                logoIcon,
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            kWidth30,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kHight20,
                Text(
                  title,
                  style: TurffTheme.lightTextTheme.headline1,
                ),
                Text(
                  subTitle,
                  style: TurffTheme.lightTextTheme.headline3,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
