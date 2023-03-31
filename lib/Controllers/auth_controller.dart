import 'dart:developer';

import 'package:barber/Controllers/user_controller.dart';
import 'package:barber/Utils/global_variables.dart';
import 'package:barber/Views/Auth/signup_view.dart';
import 'package:barber/Views/Splash/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../Methods/overlays.dart';
import '../views/Auth/otp_view.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Rxn<User> firebaseUser = Rxn<User>();
  User? get fUser => firebaseUser.value;

  @override
  void onInit() {
    firebaseUser.bindStream(auth.authStateChanges());
    if (fUser != null) {
      log(fUser!.uid);
    }
    super.onInit();
  }

  late String verificationID;
  Future<void> verifyPhonenumber(String phoneNo) async {
    try {
      loadingOverlay('Please Wait');
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (PhoneAuthCredential credential) async {
          final authResult = await auth.signInWithCredential(credential);
          final user = authResult.user;
          if (authResult.additionalUserInfo!.isNewUser) {
            Get.to(
                () => SignupView(uid: user!.uid, phoneNo: user.phoneNumber!));
          } else if (!authResult.additionalUserInfo!.isNewUser) {
            userID.value = user!.uid;
            Get.offAll(() => const SplashScreen());
          }
          log('Succeeeded');
        },
        verificationFailed: (FirebaseAuthException exception) {
          log(exception.message.toString());
          log('Above is exception....');
          Get.back();
          // throw Exception(exception);
          errorOverlay(exception.toString());
        },
        codeSent: (String verficationID, int? resendToken) {
          log(verficationID);
          log('Above is verification ID');
          verificationID = verficationID;
          Get.back();
          isOTPTimeOut.value = false;
          Get.to(() => OtpView(phoneNumber: phoneNo));
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          log('Timeout ho gia');
          isOTPTimeOut.value = true;
        },
      );
    } catch (e) {
      Get.back();
      log(e.toString());
      errorOverlay(e.toString());
      rethrow;
    }
  }

  Future<void> verifyOTP(String smsCode) async {
    try {
      loadingOverlay('Verifying');
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: smsCode);
      final authResult = await auth.signInWithCredential(credential);
      final user = authResult.user;
      if (authResult.additionalUserInfo!.isNewUser) {
        Get.back();
        Get.to(() => SignupView(uid: user!.uid, phoneNo: user.phoneNumber!));
      } else if (!authResult.additionalUserInfo!.isNewUser) {
        userID.value = user!.uid;
        Get.back();
        Get.offAll(() => const SplashScreen());
      }
    } catch (e) {
      Get.back();
      String error = e.toString().split(']').last;
      log(error);
      errorOverlay('Wrong OTP');
    }
  }

  Future<void> logout() async {
    await auth.signOut();
    Get.find<UsersController>().clearUser();
    Get.offAll(() => const SplashScreen());
  }
}
