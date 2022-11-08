
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truff_majestic/app/screens/home/controller/geolocator.dart';
import 'package:truff_majestic/app/screens/shared/themes.dart';
import 'package:truff_majestic/app/utils/constants/color_constants.dart';
import 'package:truff_majestic/app/utils/initsatate.dart';

class CustomScrollviewAppBar extends StatelessWidget {
  const CustomScrollviewAppBar({
    Key? key,
    required this.offset,
  }) : super(key: key);

  final double offset;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocationProvider>(context);
    const double maxExtent = 220;
    const double minExtent = 80;

    final double shrinkOffset = offset;

    final expendPercentage =
        1.0 - min(1, shrinkOffset / (maxExtent - minExtent));

    final double hg = minExtent + (maxExtent - minExtent) * expendPercentage;

    final interpolatedBackgroundColor = Color.lerp(
      backGrountColor,
      buttonColor,
      expendPercentage,
    );
    final interpolatedAlignment = Alignment.lerp(
      Alignment.topLeft,
      Alignment.center,
      expendPercentage,
    );

    final interpolatedTextStyle = TextStyle.lerp(
      TurffTheme.lightTextTheme.headline2,
      const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: whiteColor,
      ),
      expendPercentage,
    );

    return StatefulWrapper(
      onInit: () {
        provider.getCurrerntPosition(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        height: hg,
        color: interpolatedBackgroundColor,
        alignment: interpolatedAlignment,
        child: Row(
          children: [
            Text(
              " ${provider.currentAddress}",
              style: interpolatedTextStyle,
            ),
            Expanded(child: Container()),
            (hg == maxExtent)
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
