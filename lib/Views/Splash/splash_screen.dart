import 'package:barber/Binding/bindings.dart';
// <<<<<<< Updated upstream
import 'package:barber/Utils/global_variables.dart';
import 'package:barber/Views/Auth/login_view.dart';
// import 'package:barber/Views/Landing/landing_view.dart';

import 'package:barber/Views/Customer/Landing/landing_view.dart';
// >>>>>>> Stashed changes
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    InitBinding();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      isSignedIn.value
          ? Get.off(() => LandingView(), binding: InitBinding())
          : Get.off(() => LoginView());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/loadinggirl.json'),
      ),
    );
  }
}
