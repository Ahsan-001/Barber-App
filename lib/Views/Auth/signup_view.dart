import 'dart:developer';

import 'package:barber/Constants/locations.dart';
import 'package:barber/Methods/validator.dart';
import 'package:barber/Models/user_model.dart';
import 'package:barber/Services/db_services.dart';
import 'package:barber/Utils/date_picker.dart';
import 'package:barber/Views/Splash/splash_screen.dart';
import 'package:barber/Views/Widgets/buttons.dart';
import 'package:barber/Views/Widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Constants/colors.dart';
import '../../Constants/text_styles.dart';

class SignupView extends StatelessWidget {
  SignupView({Key? key, required this.uid, required this.phoneNo})
      : super(key: key);
  final String uid;
  final String phoneNo;

  RxBool isEnable = false.obs;
  RxBool isBarber = false.obs;
  late DateTime dob;
  final TextEditingController fNameCntrlr = TextEditingController();
  final TextEditingController lNameCntrlr = TextEditingController();
  final TextEditingController emailCntrlr = TextEditingController();
  final TextEditingController dobCntrlr = TextEditingController();
  final TextEditingController bNameCntrlr = TextEditingController();

  // RxBool isPunjab = false.obs;
  // RxBool isKPK = false.obs;
  // RxBool isSindh = false.obs;
  // RxBool isBalochistan = false.obs;
  // RxList<String> cities = OurLocations.punjabCities.obs;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTransparent,
        elevation: 0,
        iconTheme: iconTheme,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Add your info', style: kH1),
              const SizedBox(height: 10),
              const Text('Are you?', style: kH3),
              const SizedBox(height: 10),
              Obx(() => Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            isBarber.value = false;
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            decoration: BoxDecoration(
                                // border: Border.all(color: kMainColor),
                                color:
                                    isBarber.value ? kTransparent : kMainColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              'Customer',
                              style: kH3.copyWith(
                                  color: isBarber.value
                                      ? kBlackColor
                                      : kWhiteColor),
                            ),
                          ),
                        )),
                        // const SizedBox(width: 2),
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            isBarber.value = true;
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                // border: Border.all(color: kMainColor),
                                color:
                                    isBarber.value ? kMainColor : kTransparent,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Text(
                                'Barber',
                                style: kH3.copyWith(
                                    color: isBarber.value
                                        ? kWhiteColor
                                        : kBlackColor),
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  )),
              const SizedBox(height: 20),
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextAirField(
                        validators: requiredValidator,
                        title: 'First name',
                        controlller: fNameCntrlr,
                        onchange: (val) {
                          checkValidity()
                              ? isEnable.value = true
                              : isEnable.value = false;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextAirField(
                        validators: requiredValidator,
                        title: 'Last name',
                        controlller: lNameCntrlr,
                        onchange: (val) {
                          checkValidity()
                              ? isEnable.value = true
                              : isEnable.value = false;
                        },
                      ),
                      const SizedBox(height: 8),
                      const Text(' Make sure it matches the name on your CNIC.',
                          style: kGreyText),
                      const SizedBox(height: 20),
                      TextAirField(
                        validators: requiredValidator,
                        isReadOnly: true,
                        title: 'Date of Birth',
                        controlller: dobCntrlr,
                        onchange: (val) {
                          checkValidity()
                              ? isEnable.value = true
                              : isEnable.value = false;
                        },
                        ontap: () {
                          dobPicker(
                            context,
                            (val) {
                              dob = val;
                              dobCntrlr.text =
                                  DateFormat('MMMM d, ' 'yyyy').format(val);
                            },
                            () {
                              if (dobCntrlr.text == '') {
                                dob = DateTime(DateTime.now().year - 20);
                                dobCntrlr.text = DateFormat('MMMM d, ' 'yyyy')
                                    .format(DateTime(DateTime.now().year - 20));
                              }
                              Get.back();
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      TextAirField(
                        title: 'Email',
                        validators: MultiValidator([
                          requiredValidator,
                          EmailValidator(errorText: 'Enter a corrent email.')
                        ]),
                        controlller: emailCntrlr,
                        onchange: (val) {
                          checkValidity()
                              ? isEnable.value = true
                              : isEnable.value = false;
                        },
                      ),
                    ],
                  )),
              const SizedBox(height: 8),
              const Text('We\'ll email you a reservation confirmation.',
                  style: kGreyText),
              // Obx(
              //   () => isBarber.value
              //       ? Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             const SizedBox(height: 20),
              //             const Text('Please provide your Business Info',
              //                 style: kH3),
              //             const SizedBox(height: 10),
              //             TextAirField(
              //               validators: requiredValidator,
              //               title: 'Business name',
              //               controlller: bNameCntrlr,
              //               onchange: (val) {
              //                 checkValidity()
              //                     ? isEnable.value = true
              //                     : isEnable.value = false;
              //               },
              //             ),
              //             const SizedBox(height: 10),
              //             TextAirField(
              //               validators: requiredValidator,
              //               title: 'Street Address',
              //               controlller: sAddressCntrlr,
              //               lines: 3,
              //               onchange: (val) {
              //                 checkValidity()
              //                     ? isEnable.value = true
              //                     : isEnable.value = false;
              //               },
              //             ),
              //             const SizedBox(height: 10),
              //             DropDownField(
              //               listOfSelection: OurLocations.provinces,
              //               title: 'Select Province',
              //               hint: 'Select Province',
              //               onchange: (val) {
              //                 log(val.toString());
              //                 switch (val) {
              //                   case 'Punjab':
              //                     {
              //                       provinceCntrlr.text = val!;
              //                       cityCntrlr.text =
              //                           OurLocations.punjabCities[0];
              //                       isPunjab.value = true;
              //                       isKPK.value = false;
              //                       isSindh.value = false;
              //                       isBalochistan.value = false;
              //                       log(cityCntrlr.text);
              //                     }
              //                     break;
              //                   case 'KPK':
              //                     {
              //                       provinceCntrlr.text = val!;
              //                       cityCntrlr.text = OurLocations.kpkCities[0];
              //                       isPunjab.value = false;
              //                       isKPK.value = true;
              //                       isSindh.value = false;
              //                       isBalochistan.value = false;
              //                     }
              //                     break;
              //                   case 'Sindh':
              //                     {
              //                       provinceCntrlr.text = val!;
              //                       cityCntrlr.text =
              //                           OurLocations.sindhCities[0];
              //                       isPunjab.value = false;
              //                       isKPK.value = false;
              //                       isSindh.value = true;
              //                       isBalochistan.value = false;
              //                     }
              //                     break;
              //                   case 'Balochistan':
              //                     {
              //                       provinceCntrlr.text = val!;
              //                       cityCntrlr.text =
              //                           OurLocations.balochistanCities[0];
              //                       isPunjab.value = false;
              //                       isKPK.value = false;
              //                       isSindh.value = false;
              //                       isBalochistan.value = true;
              //                     }
              //                     break;
              //                   default:
              //                 }
              //                 provinceCntrlr.text = val!;
              //               },
              //             ),
              //             const SizedBox(height: 10),
              //             Obx(
              //               () => Column(
              //                 children: [
              //                   isPunjab.value
              //                       ? DropDownField(
              //                           listOfSelection:
              //                               OurLocations.punjabCities,
              //                           title: 'Select City',
              //                           hint: cityCntrlr.text,
              //                           onchange: (val) {
              //                             cityCntrlr.text = val!;
              //                           },
              //                         )
              //                       : const SizedBox(),
              //                   isKPK.value
              //                       ? DropDownField(
              //                           listOfSelection: OurLocations.kpkCities,
              //                           title: 'Select City',
              //                           hint: cityCntrlr.text,
              //                           onchange: (val) {
              //                             cityCntrlr.text = val!;
              //                           },
              //                         )
              //                       : const SizedBox(),
              //                   isSindh.value
              //                       ? DropDownField(
              //                           listOfSelection:
              //                               OurLocations.sindhCities,
              //                           title: 'Select City',
              //                           hint: cityCntrlr.text,
              //                           onchange: (val) {
              //                             cityCntrlr.text = val!;
              //                           },
              //                         )
              //                       : const SizedBox(),
              //                   isBalochistan.value
              //                       ? DropDownField(
              //                           listOfSelection:
              //                               OurLocations.balochistanCities,
              //                           title: 'Select City',
              //                           hint: cityCntrlr.text,
              //                           onchange: (val) {
              //                             cityCntrlr.text = val!;
              //                           },
              //                         )
              //                       : const SizedBox(),
              //                 ],
              //               ),
              //             ),
              //             const SizedBox(height: 10),
              //           ],
              //         )
              //       : const SizedBox(),
              // ),
              const SizedBox(height: 30),
              DynamicHeavyButton(
                width: double.infinity,
                isEnable: isEnable,
                ontap: () async {
                  if (_formKey.currentState!.validate()) {
                    log('Valid');
                    UsersModel usersModel = UsersModel(
                      uid: uid,
                      phoneNumber: phoneNo,
                      firstName: fNameCntrlr.text,
                      lastName: lNameCntrlr.text,
                      email: emailCntrlr.text,
                      profileImage: '',
                      createdAt: DateTime.now(),
                      dob: dob,
                      aboutMe: '',
                      isRegistered: true,
                      isBarber: isBarber.value,
                    );
                    await UserDBServices().createUser(usersModel);
                    Get.offAll(() => const SplashScreen());
                  }
                },
                onDisableTap: () {
                  _formKey.currentState!.validate();
                },
                lable: 'Next',
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  bool checkValidity() {
    if (fNameCntrlr.text != '' &&
        lNameCntrlr.text != '' &&
        dobCntrlr.text != '' &&
        emailCntrlr.text != '') {
      return _formKey.currentState!.validate() ? true : false;
    } else {
      return false;
    }
  }
}
