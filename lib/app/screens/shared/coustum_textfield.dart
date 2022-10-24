import 'package:flutter/material.dart';
import 'package:truff_majestic/app/utils/constants/color_constants.dart';

class CoustmTextField extends StatelessWidget {
  const CoustmTextField({
    Key? key,
    required this.label,
    required this.controllerName,
    required this.preFixIcon,
    this.sufixIconBtn,
    required this.validationMsg,
    this.isObsure = false, required this.keyBordType, this.validation,
  }) : super(key: key);
  final String label;
  final TextEditingController controllerName;
  final IconData preFixIcon;
  final IconButton? sufixIconBtn;
  final String validationMsg;
  final bool isObsure;
  final TextInputType keyBordType;
  final String? Function(String?)? validation;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObsure,
      controller: controllerName,
      keyboardType:keyBordType ,
      decoration: InputDecoration(
        
          filled: true,
          fillColor: Colors.blue.shade100,
          border: const OutlineInputBorder(),
          labelText: label,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: subTextColor),
          ),
          prefixIcon: Icon(preFixIcon),
          suffixIcon: sufixIconBtn),
      validator:  validation
    );
  }
}
