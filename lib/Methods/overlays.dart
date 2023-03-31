import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glyphicon/glyphicon.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../Constants/colors.dart';

Widget loadingWidget = SizedBox(
    width: 50,
    child: LoadingAnimationWidget.staggeredDotsWave(
      color: kMainColor,
      size: 50,
    ));

// final loadingOverlay = loadingOverlaye();

Future<dynamic> loadingOverlay(String? text) {
  return Get.defaultDialog(
      title: text ?? 'Loading',
      content: loadingWidget,
      barrierDismissible: false);
}

void errorOverlay(String text) {
  Get.defaultDialog(title: 'Failed', content: Text(text));
}

void successOverlay(String text) {
  Get.defaultDialog(
    title: 'Successful',
    content: Column(
      children: [
        const Icon(Glyphicon.bag_check, color: kGreenColor, size: 50),
        const SizedBox(height: 8),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(text))
      ],
    ),
  );
}
