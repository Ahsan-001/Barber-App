import 'package:barber/Models/user_model.dart';
import 'package:barber/Services/db_services.dart';
import 'package:barber/Utils/global_variables.dart';
import 'package:get/get.dart';

class UsersController extends GetxController {
  Rxn<UsersModel> usersData = Rxn<UsersModel>();

  UsersModel? get user => usersData.value;

  @override
  void onInit() {
    if (isSignedIn.value) {
      usersData.bindStream(
          Stream.fromFuture(UserDBServices().getUser(userID.value)));
    }

    super.onInit();
  }

  void clearUser() {
    usersData.value = UsersModel();
  }
}
