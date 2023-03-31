import 'package:barber/Constants/colors.dart';
import 'package:barber/Controllers/auth_controller.dart';
import 'package:barber/Views/Widgets/buttons.dart';
import 'package:barber/Views/Widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final TextEditingController phoneCntrlr = TextEditingController();
  final RxBool isEnable = false.obs;
  final AuthController authCntrlr = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(backgroundColor: kTransparent, elevation: 0),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Log in or Sign up to Barberia',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextAirField(
                  title: 'Phone Number',
                  prefix: '+92 ',
                  hintText: '3001234567',
                  inputType: TextInputType.phone,
                  controlller: phoneCntrlr,
                  onchange: (val) {
                    phoneCntrlr.text.length == 10
                        ? isEnable.value = true
                        : isEnable.value = false;
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  'We\'ll call or text you to confirm your number. Standard message and data rates apply.',
                  style: TextStyle(
                    fontSize: 12,
                    color: kGreyColor,
                  ),
                ),
                const SizedBox(height: 20),
                DynamicHeavyButton(
                  width: double.infinity,
                  isEnable: isEnable,
                  lable: 'Continue',
                  ontap: () async {
                    String phone = '+92' + phoneCntrlr.text;
                    await authCntrlr.verifyPhonenumber(phone);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
