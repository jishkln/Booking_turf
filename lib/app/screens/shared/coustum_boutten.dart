import 'package:flutter/material.dart';
 
class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.buttonName,
    required this.onTap,
  }) : super(key: key);
  final Widget buttonName;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 90),
      child: SizedBox(
        height: 50,
        width: 160,
        child: ElevatedButton(
          onPressed: onTap,
          child:
            buttonName,
           
          
        ),
      ),
    );
  }
}
