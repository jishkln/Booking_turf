import 'package:flutter/material.dart';
import 'package:truff_majestic/app/screens/shared/themes.dart';
import 'package:truff_majestic/app/utils/constants/color_constants.dart';

class CoustomContainerWidget extends StatelessWidget {
  const CoustomContainerWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.location,
  }) : super(key: key);
  final String image;
  final String title;
  final String location;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints.expand(
          width: size.width * .43, height: size.height * .2),
      decoration: const BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 135,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.fitHeight),
            ),
          ),
          Positioned(
            bottom: 35,
            left: 15,
            right: 10,
            child: SizedBox(
              width: size.width,
              child: Text(
                title,
                style: TurffTheme.lightTextTheme.headline6,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 15, bottom: 15),
              width: size.width * .32,
              child: Text(
                location,
                style: TurffTheme.lightTextTheme.headline3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 150,
            right: 0,
            child: SizedBox(
              width: size.width,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: greyColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
