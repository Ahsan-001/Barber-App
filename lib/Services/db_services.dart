import 'dart:developer';

import 'package:barber/Methods/overlays.dart';
import 'package:barber/Models/user_model.dart';
import 'package:barber/Utils/global_variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserDBServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static String users = 'users';
  Future<void> createUser(UsersModel usersModel) async {
    try {
      await firestore
          .collection(users)
          .doc(usersModel.uid)
          .set(usersModel.toJSON());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<UsersModel> getUser(String userID) async {
    try {
      final retrval = await firestore
          .collection(users)
          .doc(userID)
          .get()
          .then((DocumentSnapshot doc) {
        UsersModel data = UsersModel();
        data = UsersModel.fromFirestore(doc);

        return data;
      });
      return retrval;
    } catch (e) {
      Get.snackbar('User failed', e.toString());
      rethrow;
    }
  }

  Future<void> updateUser(UsersModel usersModel) async {
    try {
      await firestore
          .collection(users)
          .doc(userID.value)
          .update(usersModel.toJSONforUpdate());
    } catch (e) {
      errorOverlay(e.toString());
    }
  }

  Future<void> switchProfile(bool status) async {
    try {
      await firestore
          .collection(users)
          .doc(userID.value)
          .update({'isBarber': status});
    } catch (e) {
      errorOverlay(e.toString());
    }
  }
}
