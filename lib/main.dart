import 'package:barber/Binding/bindings.dart';
import 'package:barber/Constants/colors.dart';
import 'package:barber/Controllers/auth_controller.dart';
import 'package:barber/Views/Splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'Models/system_overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(darkIconSystemOverlay());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(primarySwatch: kPrimaryColor),
      debugShowCheckedModeBanner: false,
      initialBinding: InitBinding(),
      home: const SplashScreen(),
    );
  }
}
