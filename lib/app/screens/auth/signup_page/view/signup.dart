import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import 'package:provider/provider.dart';
import 'package:truff_majestic/app/screens/auth/login_page/view/login_email.dart';
import 'package:truff_majestic/app/screens/auth/signup_page/controller/signup_provider.dart'; 
import 'package:truff_majestic/app/screens/shared/coustem_card.dart';
import 'package:truff_majestic/app/screens/shared/coustum_boutten.dart';
import 'package:truff_majestic/app/screens/shared/coustum_textfield.dart';
import 'package:truff_majestic/app/screens/shared/rich_textbtn.dart';
import 'package:truff_majestic/app/utils/constants/color_constants.dart';
import 'package:truff_majestic/app/utils/constants/images.dart';
import 'package:truff_majestic/app/utils/constants/size_constants.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    SignupProvider signupController = Provider.of<SignupProvider>(context);

    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            const CoustemCard(
              title: 'Sign up',
              subTitle: 'Create an account',
            ),
            Image.asset(
              logoImg,
              width: 200,
              height: 250,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 26.0),
              child: RichTextBtn(
                text: 'Already have an account? \t',
                buttonName: 'Sign in',
                onClick: () {
                  // Fluttertoast.showToast(msg: "msg");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginEmail()),
                  );
                  log("SignUp :${signupController.signupKey.hashCode.toString()}");
                },
              ),
            ),
            kHight20,
            Padding(
              padding: const EdgeInsets.all(26.0),
              child: Form(
                key: signupController.signupKey,
                child: Column(
                  children: [
                    CoustmTextField(
                      controllerName: signupController.enamilController,
                      label: 'Email',
                      preFixIcon: (Icons.email),
                      validationMsg: 'Enter a Valid Email',
                      keyBordType: TextInputType.emailAddress,
                    ),
                    kHight20,
                    CoustmTextField(
                      controllerName: signupController.passwordControlller,
                      isObsure: signupController.isPassVisible,
                      label: 'Password',
                      preFixIcon: (Icons.lock),
                      validationMsg: 'Password warnning',
                      keyBordType: TextInputType.text,
                    ),
                    kHight20,
                    CoustmTextField(
                      controllerName: signupController.conformPassword,
                      isObsure: signupController.isPassVisible,
                      label: 'Password',
                      preFixIcon: (Icons.lock),
                      validationMsg: ' Password not match',
                      sufixIconBtn: IconButton(
                        onPressed: () {
                          signupController.visiblePass();
                        },
                        icon: signupController.isPassVisible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                      keyBordType: TextInputType.text,
                    ),
                    kHight20,
                    SizedBox(
                      width: size.width,
                      child: Selector<SignupProvider, bool>(
                          selector: (context, value) => value.isLoading,
                          builder: (context, isLloading, _) {
                            return SubmitButton(
                                buttonName: isLloading
                                    ? const CupertinoActivityIndicator(
                                        color: whiteColor,
                                      )
                                    : const Text('O T P'),
                                onTap: () {
                                  signupController.emailVerify(context);
                                });
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
