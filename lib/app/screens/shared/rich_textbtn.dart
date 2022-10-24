import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:truff_majestic/app/screens/shared/themes.dart';

class RichTextBtn extends StatelessWidget {
  const RichTextBtn({
    Key? key,
    required this.buttonName,
    required this.text,
    required this.onClick,
  }) : super(key: key);
  final String buttonName;
  final String text;
  final void Function() onClick;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: text,
          style: TurffTheme.lightTextTheme.bodyText1,
          children: <TextSpan>[
            TextSpan(
              text: buttonName,
              style: const TextStyle(color: Colors.blueAccent, fontSize: 16),
              recognizer: TapGestureRecognizer()..onTap = onClick,
            )
          ]),
    );
  }
}
