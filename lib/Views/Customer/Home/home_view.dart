import 'package:barber/Constants/text_styles.dart';
import 'package:barber/Controllers/user_controller.dart';
import 'package:barber/Utils/global_variables.dart';
import 'package:barber/Views/Auth/login_view.dart';
import 'package:barber/Views/Auth/signup_view.dart';
// import 'package:barber/Views/Widgets/loginnow_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final UsersController userContrlr = Get.find<UsersController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isSignedIn.value ? const SizedBox() : LoginView(),
                MaterialButton(
                  onPressed: () {
                    Get.to(() => SignupView(uid: 'aa', phoneNo: 'phoneNo'));
                  },
                  child: isSignedIn.value
                      ? Obx(() => userContrlr.user == null
                          ? const CircularProgressIndicator.adaptive()
                          : Column(
                              children: [
                                userContrlr.user!.isBarber!
                                    ? const Text(' This is Barber')
                                    : const Text(' This is Customer'),
                                const SizedBox(height: 6),
                                const Text(
                                    'To convert profile, go to Account view and switch the profile',
                                    style: kGreyText)
                              ],
                            ))
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
