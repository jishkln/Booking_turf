import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truff_majestic/app/screens/auth/login_page/controller/login_provider.dart';
import 'package:truff_majestic/app/screens/auth/login_page/view/login_email.dart'; 
import 'package:truff_majestic/app/screens/shared/coustem_card.dart';
import 'package:truff_majestic/app/screens/shared/coustum_boutten.dart';
import 'package:truff_majestic/app/screens/shared/coustum_textfield.dart';
 import 'package:truff_majestic/app/screens/shared/themes.dart';
import 'package:truff_majestic/app/utils/constants/color_constants.dart';
import 'package:truff_majestic/app/utils/constants/images.dart';
import 'package:truff_majestic/app/utils/constants/size_constants.dart';

class LoginPhone extends StatelessWidget {
  const LoginPhone({super.key});

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
              subTitle: 'With your account',
            ),
            Image.asset(
              logoImg,
              width: 200,
              height: 250,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 150.0),
            //   child: RichTextBtn(
            //     text: 'Don\'t have an account? \t',
            //     buttonName: 'Sign Up',
            //     onClick: () {
            //       Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(builder: (context) => const LoginEmail()),
            //       );
            //     },
            //   ),
            // ),

            Padding(
              padding: const EdgeInsets.fromLTRB(26, 18, 26, 16),
              child: Form(
                key: loginController.formKeyPhone,
                child: Column(
                  children: [
                    kHight20,
                    CoustmTextField(
                      controllerName: loginController.phoneControlller,
                      label: 'Phone number',
                      preFixIcon: (Icons.person),
                      validationMsg: 'Enter a Valid number',
                      keyBordType: TextInputType.number,
                      
                    ),
                    kHight20,
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
                                        'O T P',
                                        style:
                                            TurffTheme.darkTextTheme.headline6,
                                      ),
                                onTap: () {
                                  loginController.phoneLogin(context);
                                });
                          }),
                    ),
                  ],
                ),
              ),
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
            SizedBox(
              width: size.width - 100,
              child: SubmitButton(
                  buttonName: Text(
                    'With Email',
                    style: TurffTheme.darkTextTheme.headline6,
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginEmail(),
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
