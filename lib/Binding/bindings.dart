import 'dart:developer';

import 'package:barber/Controllers/auth_controller.dart';
import 'package:barber/Controllers/user_controller.dart';
import 'package:barber/Utils/global_variables.dart';
import 'package:get/get.dart';

class InitBinding extends Bindings {
  final authCntrlr = Get.put<AuthController>(AuthController());
  @override
  void dependencies() {
    if (authCntrlr.fUser != null) {
      isSignedIn.value = true;
      userID.value = authCntrlr.fUser!.uid;
      log('User Found:::: ${userID.value}');
      Get.put(UsersController()).onInit();
    } else {
      log('user not found');
      userID.value = '';
      isSignedIn.value = false;
      Get.put(UsersController());
    }
  }
}
