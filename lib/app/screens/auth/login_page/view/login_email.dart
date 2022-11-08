import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truff_majestic/app/screens/auth/login_page/controller/login_provider.dart';
import 'package:truff_majestic/app/screens/auth/login_page/view/login_phone.dart';
import 'package:truff_majestic/app/screens/auth/signup_page/view/signup.dart';
import 'package:truff_majestic/app/screens/shared/coustem_card.dart';
import 'package:truff_majestic/app/screens/shared/coustum_boutten.dart';
import 'package:truff_majestic/app/screens/shared/coustum_textfield.dart';
import 'package:truff_majestic/app/screens/shared/rich_textbtn.dart';
import 'package:truff_majestic/app/screens/shared/themes.dart';
import 'package:truff_majestic/app/utils/constants/color_constants.dart';
import 'package:truff_majestic/app/utils/constants/images.dart';
import 'package:truff_majestic/app/utils/constants/size_constants.dart';

class LoginEmail extends StatelessWidget {
  const LoginEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginProvider>(context);

    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            const CoustemCard(
              title: 'Login',
              subTitle: 'Your account',
            ),
            Image.asset(
              logoImg,
              width: 200,
              height: 250,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 26.0),
              child: RichTextBtn(
                text: 'Don\'t have an account? \t',
                buttonName: 'Sign Up',
                onClick: () {
                  // Routes.push(screen: const SignUp());
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUp()),
                  );
                },
              ),
            ),
            kHight20,
            Padding(
              padding: const EdgeInsets.fromLTRB(26, 18, 26, 16),
              child: Form(
                key: loginController.formKeyEmail,
                child: Column(
                  children: [
                    CoustmTextField(
                      controllerName: loginController.emailController,
                      label: 'Email',
                      preFixIcon: (Icons.email),
                      validationMsg: 'Enter a Valid Email',
                      keyBordType: TextInputType.emailAddress,
                    ),
                    kHight20,
                    CoustmTextField(
                      controllerName: loginController.passwordController,
                      isObsure: loginController.isPassVisible,
                      label: 'Password',
                      preFixIcon: (Icons.lock),
                      validationMsg: 'Enter a Valid Password',
                      sufixIconBtn: IconButton(
                        onPressed: () {
                          loginController.visiblePass();
                        },
                        icon: loginController.isPassVisible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                      keyBordType: TextInputType.text,
                    ),
                    SizedBox(
                      width: size.width,
                      child: Selector<LoginProvider, bool>(
                          selector: (context, value) => value.isLoading,
                          builder: (context, isLoading, _) {
                            return SubmitButton(
                                buttonName: isLoading
                                    ? const CupertinoActivityIndicator(
                                        color: whiteColor,
                                      )
                                    : Text(
                                        'Login',
                                        style:
                                            TurffTheme.darkTextTheme.headline6,
                                      ),
                                onTap: () {
                                  loginController.emailLogin(context);
                                });
                          }),
                    ),
                    //kHight10,
                    Row(
                      children: [
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Divider(
                              color: blackColor,
                            ),
                          ),
                        ),
                        Text(
                          'Or',
                          style: TurffTheme.lightTextTheme.headline3,
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Divider(
                              color: blackColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: size.width - 80,
              child: SubmitButton(
                  buttonName: Text(
                    'With phone',
                    style: TurffTheme.darkTextTheme.headline6,
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPhone(),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
