import 'package:barber/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DynamicHeavyButton extends StatelessWidget {
  const DynamicHeavyButton({
    Key? key,
    required this.isEnable,
    required this.ontap,
    required this.lable,
    this.height,
    this.width,
    this.onDisableTap,
    this.horizontalMargin,
    this.color = kMainColor,
  }) : super(key: key);

  final RxBool isEnable;
  final VoidCallback ontap;
  final VoidCallback? onDisableTap;
  final String lable;
  final double? height, width;
  final double? horizontalMargin;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin ?? 0),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isEnable.value ? color : kGreyColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: MaterialButton(
          onPressed: isEnable.value ? ontap : onDisableTap ?? () {},
          child: Text(
            lable,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: kWhiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
