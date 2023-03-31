import 'dart:developer';

import 'package:barber/Controllers/auth_controller.dart';
import 'package:barber/Methods/overlays.dart';
import 'package:barber/Utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../../Constants/colors.dart';
import '../../Constants/text_styles.dart';

class OtpView extends StatelessWidget {
  OtpView({Key? key, required this.phoneNumber}) : super(key: key);
  final String phoneNumber;
  String otpCode = '';
  RxBool isLoading = false.obs;
  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTransparent,
        elevation: 0,
        iconTheme: iconTheme,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Confirm your number', style: kH1),
            const SizedBox(height: 10),
            Text('Enter the code we sent over SMS to $phoneNumber'),
            const SizedBox(height: 20),
            SizedBox(
              width: 350,
              child: OTPTextField(
                length: 6,
                fieldWidth: 50,
                onChanged: (pin) {},
                style: const TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                otpFieldStyle: OtpFieldStyle(
                  enabledBorderColor: kBlackColor,
                  // borderColor: kMainColor,
                  focusBorderColor: kMainColor,
                ),
                onCompleted: (pin) async {
                  loadingOverlay;
                  otpCode = pin;
                  log(pin.toString());
                  // Get.to(() => SignupView(uid: 'uid', phoneNo: 'phoneNo'));
                  await authController.verifyOTP(pin);
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Obx(
                () => isLoading.value
                    ? loadingWidget
                    : Row(
                        children: [
                          const Text('Didn\'t get the code?'),
                          isOTPTimeOut.value
                              ? TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text('Resend OTP',
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.underline)))
                              : TextButton(
                                  onPressed: () {},
                                  child: const Text('Resend OTP',
                                      style: kGreyText)),
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
