import 'dart:io';

import 'package:barber/Constants/colors.dart';
// import 'package:barber/Constants/text_styles.dart';
import 'package:barber/Controllers/user_controller.dart';
import 'package:barber/Methods/overlays.dart';
import 'package:barber/Models/user_model.dart';
import 'package:barber/Services/db_services.dart';
// import 'package:barber/Services/storage_service.dart';
import 'package:barber/Utils/date_picker.dart';
import 'package:barber/Utils/image_picker.dart';
// import 'package:barber/Views/Widgets/net_image.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewAndEditProfile extends StatelessWidget {
  ViewAndEditProfile({Key? key}) : super(key: key);

  final RxBool isSaving = false.obs;
  final RxBool isImgUploading = false.obs;
  final RxString imageUpdatePath = ''.obs;
  late DateTime dob;
  final UsersController usersCtlr = Get.find<UsersController>();

  @override
  Widget build(BuildContext context) {
    dob = usersCtlr.user!.dob!;
    final TextEditingController fNameCntrlr =
        TextEditingController(text: usersCtlr.user!.firstName);
    final TextEditingController lNameCntrlr =
        TextEditingController(text: usersCtlr.user!.lastName);
    final TextEditingController aboutMeCntrlr =
        TextEditingController(text: usersCtlr.user!.aboutMe);
    final TextEditingController dobCntrlr = TextEditingController(
        text: DateFormat('MMM d, ' 'yyyy').format(usersCtlr.user!.dob!));

    final TextEditingController emailCntrlr =
        TextEditingController(text: usersCtlr.user!.email);
    final TextEditingController phoneCntrlr =
        TextEditingController(text: usersCtlr.user!.phoneNumber);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 1,
        iconTheme: iconTheme,
        centerTitle: true,
        title: const Text(
          'PROFILE',
          style: TextStyle(color: kBlackColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          MaterialButton(
              onPressed: () async {
                isSaving.value = true;
                try {
                  late String? dpUpdateURL;

                  if (imageUpdatePath.value != '') {
                    isImgUploading.value = true;
                    dpUpdateURL = await StorageService().imgageUpload(
                        'Users/${usersCtlr.user!.uid}/ProfilePicture/DP',
                        imageUpdatePath.value);
                    isImgUploading.value = false;
                  } else {
                    dpUpdateURL = usersCtlr.user!.profileImage;
                  }

                  UsersModel usersModel = UsersModel(
                    firstName: fNameCntrlr.text,
                    lastName: lNameCntrlr.text,
                    aboutMe: aboutMeCntrlr.text,
                    email: emailCntrlr.text,
                    profileImage: dpUpdateURL,
                    dob: dob,
                  );
                  await UserDBServices().updateUser(usersModel);
                  usersCtlr.onInit();
                  Get.back();
                } catch (e) {
                  errorOverlay(e.toString());
                }
                isSaving.value = false;
              },
              child: const Text('SAVE'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => isSaving.value
                  ? const LinearProgressIndicator()
                  : const SizedBox()),
              const SizedBox(height: 20),
              DPUpdateWidget(
                imageUpdatePath: imageUpdatePath,
                imageURL: usersCtlr.user!.profileImage,
                isUploading: isImgUploading,
              ),
              const SizedBox(height: 8),
              const Text('Profile Picture'),
              const SizedBox(height: 15),
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: SimpleTextField(
                          lable: 'First Name', controller: fNameCntrlr),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SimpleTextField(
                          lable: 'Last Name', controller: lNameCntrlr),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              SimpleTextField(lable: 'About Me', controller: aboutMeCntrlr),
              const SizedBox(height: 6),
              SimpleTextField(
                lable: 'Date of Birth',
                controller: dobCntrlr,
                isReadOnly: true,
                suffix: const Icon(Icons.date_range_outlined),
                ontap: () {
                  dobPicker(
                    context,
                    (val) {
                      dob = val;
                      dobCntrlr.text = DateFormat('MMM d, ' 'yyyy').format(val);
                    },
                    () {
                      if (dobCntrlr.text == '') {
                        dob = DateTime(DateTime.now().year - 20);
                        dobCntrlr.text = DateFormat('MMM d, ' 'yyyy')
                            .format(DateTime(DateTime.now().year - 20));
                      }
                      Get.back();
                    },
                  );
                },
              ),
              const SizedBox(height: 6),
              SimpleTextField(lable: 'Email', controller: emailCntrlr),
              const SizedBox(height: 6),
              SimpleTextField(
                lable: 'Phone Number',
                controller: phoneCntrlr,
                isEnable: false,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class DPUpdateWidget extends StatelessWidget {
  const DPUpdateWidget({
    Key? key,
    required this.imageUpdatePath,
    required this.isUploading,
    this.imageURL,
  }) : super(key: key);

  final RxString imageUpdatePath;
  final RxBool isUploading;
  final String? imageURL;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      alignment: Alignment.center,
      child: Stack(
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: ClipOval(
                child: Obx(() => imageUpdatePath.value != ''
                    ? Image.file(File(imageUpdatePath.value))
                    : imageURL != ''
                        ? Image.network(imageURL!)
                        : Image.asset('assets/User.png'))),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: MaterialButton(
                padding: const EdgeInsets.all(10),
                elevation: 0,
                shape: const CircleBorder(),
                color: kWhiteColor,
                onPressed: () async {
                  imageUpdatePath.value =
                      await ImagePickerService().imageFromCamera();
                },
                child: const Icon(Icons.camera_alt_rounded)),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: MaterialButton(
                padding: const EdgeInsets.all(10),
                elevation: 0,
                shape: const CircleBorder(),
                color: kWhiteColor,
                onPressed: () async {
                  imageUpdatePath.value =
                      await ImagePickerService().imageFromGellery();
                },
                child: const Icon(Icons.photo_library)),
          ),
          Obx(() => isUploading.value
              ? const Positioned.fill(
                  child: CircularProgressIndicator.adaptive())
              : const SizedBox()),
        ],
      ),
    );
  }
}

class SimpleTextField extends StatelessWidget {
  const SimpleTextField({
    Key? key,
    this.lable,
    this.isReadOnly,
    this.ontap,
    this.controller,
    this.isEnable,
    this.suffix,
  }) : super(key: key);
  final String? lable;
  final bool? isReadOnly;
  final bool? isEnable;
  final VoidCallback? ontap;
  final TextEditingController? controller;
  final Widget? suffix;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isReadOnly ?? false,
      controller: controller,
      onTap: ontap,
      enabled: isEnable,
      decoration: InputDecoration(
        suffixIcon: suffix,
        label: lable != null ? Text(lable!) : null,
        // labelStyle: kBoldText,
      ),
    );
  }
}
