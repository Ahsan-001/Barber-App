import 'package:flutter/material.dart';

Map<int, Color> color = {
  50: const Color.fromRGBO(255, 255, 255, .1),
  100: const Color.fromRGBO(255, 255, 255, .2),
  200: const Color.fromRGBO(255, 255, 255, .3),
  300: const Color.fromRGBO(255, 255, 255, .4),
  400: const Color.fromRGBO(255, 255, 255, .5),
  500: const Color.fromRGBO(255, 255, 255, .6),
  600: const Color.fromRGBO(255, 255, 255, .7),
  700: const Color.fromRGBO(255, 255, 255, .8),
  800: const Color.fromRGBO(255, 255, 255, .9),
  900: const Color.fromRGBO(255, 255, 255, 1),
};

MaterialColor kPrimaryColor = MaterialColor(0xFF13268A, color);

const Color kDarkBlueColor = Color(0xff141A3A);
const Color kGreyColor = Colors.grey;
const Color kTransparent = Colors.transparent;
const Color kBlackColor = Colors.black;
const Color kErrorColor = Color.fromARGB(255, 139, 35, 27);
const Color kDisableColor = Color(0xff727272);
const Color kFadedColor = Color(0xffD8D8D8);
const Color kWhiteColor = Color(0xffffffff);
const Color kMainFadedColor = Color(0xff7089A7);
const Color kMainColor = Color(0xff13268A);
const Color kGreenColor = Color.fromARGB(255, 12, 80, 14);

const IconThemeData iconTheme = IconThemeData(
  color: kBlackColor, //change your color here
);
