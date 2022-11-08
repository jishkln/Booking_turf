import 'package:flutter/material.dart';
import 'package:truff_majestic/app/utils/constants/color_constants.dart';
import 'package:truff_majestic/app/utils/constants/size_constants.dart';
import 'package:shimmer/shimmer.dart';

class Shimer {
  static Widget itemShimmer({required double height, required double weidth}) {


    
    return Shimmer.fromColors(
      baseColor: lightGreyColor,
      highlightColor: greyColor.withOpacity(.4),
      child: Container(
        margin: const EdgeInsets.all(4),
        height: height,
        width: weidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: 180,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            kHight10,
            Row(
              children: const [
                CircleAvatar(
                  radius: 8,
                ),
                CircleAvatar(
                  radius: 8,
                ),
                CircleAvatar(
                  radius: 8,
                ),
                CircleAvatar(
                  radius: 8,
                ),
              ],
            ),
            kHight10,
            Container(
              height: 30,
              width: 180,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
