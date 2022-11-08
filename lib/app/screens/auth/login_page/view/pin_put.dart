import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:truff_majestic/app/screens/auth/signup_page/controller/signup_provider.dart';
import 'package:truff_majestic/app/screens/shared/themes.dart';
import 'package:truff_majestic/app/utils/constants/color_constants.dart';
import 'package:truff_majestic/app/utils/constants/size_constants.dart';
import 'package:truff_majestic/app/utils/navigation.dart';

class Otp extends StatelessWidget {
  const Otp({super.key, required this.isEmail});
  final bool isEmail;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final otpContrllr = context.read<SignupProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                NavigationServices.back();
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 10,
                color: backGrountColor,
                child: SizedBox(
                  height: size.height * .6,
                  child: Center(
                    child: Form(
                      key:
                          // isEmail?
                          otpContrllr.formKeyEmailOtp,
                      // :otpPhoneController.formKeyPhone,
                      child: Column(
                        children: [
                          kHight20,
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 100, top: 50),
                            child: Text(
                              'Enter the otp',
                              style: TurffTheme.lightTextTheme.headline1,
                            ),
                          ),
                          kHight20,
                          SizedBox(
                            child: Pinput(
                              controller:
                                  // isEmail?
                                  otpContrllr.enamilOtpController,
                              // :otpPhoneController.otpPhoneController,
                              length:
                                  //  isEmail ?
                                  4,
                              // : 6,
                              androidSmsAutofillMethod:
                                  AndroidSmsAutofillMethod.smsUserConsentApi,
                              hapticFeedbackType:
                                  HapticFeedbackType.lightImpact,
                              listenForMultipleSmsOnAndroid: true,
                              focusNode: FocusNode(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "enter the otp";
                                } else {
                                  if (value.length < 4) {
                                    return "Enter a valid otp";
                                  }
                                }
                                return null;
                              },
                              onCompleted: (pin) =>
                                  // isEmail?
                                  otpContrllr.verifyEmailOtp(context, pin),
                              // :otpPhoneController.phoneOtpVerify(context, pin),
                              defaultPinTheme: PinTheme(
                                height: 60.0,
                                width: 60.0,
                                textStyle: GoogleFonts.urbanist(
                                  fontSize: 24.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.5),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              focusedPinTheme: PinTheme(
                                height: 60.0,
                                width: 60.0,
                                textStyle: GoogleFonts.urbanist(
                                  fontSize: 24.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // kHight20,
                          // kHight20,
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 20),
                          //   child: Selector<SignupProvider, bool>(
                          //       selector: (context, value) => value.isLoading,
                          //       builder: (context, isLoading, _) {
                          //         return SubmitButton(
                          //             buttonName: isLoading
                          //                 ? const CupertinoActivityIndicator(
                          //                     color: whiteColor,
                          //                   )
                          //                 : Text(
                          //                     'Submit',
                          //                     style: TurffTheme
                          //                         .darkTextTheme.headline6,
                          //                   ),
                          //             onTap: () {
                          //               Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                     builder: (context) =>
                          //                         const Home()),
                          //               );
                          //             });
                          //       }),
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
