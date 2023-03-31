import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  String? uid;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? email;
  String? profileImage;
  DateTime? createdAt;
  DateTime? dob;
  String? aboutMe;
  bool? isRegistered;
  bool? isBarber;

  UsersModel({
    this.uid,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.email,
    this.createdAt,
    this.dob,
    this.profileImage,
    this.aboutMe,
    this.isRegistered,
    this.isBarber,
  });

  UsersModel.fromFirestore(DocumentSnapshot docs) {
    uid = docs.get('uid');
    phoneNumber = docs.get('phoneNumber');
    firstName = docs.get('firstName');
    lastName = docs.get('lastName');
    email = docs.get('email');
    createdAt = (docs.get('createdAt') as Timestamp).toDate();
    dob = (docs.get('dob') as Timestamp).toDate();
    profileImage = docs.get('profileImage');
    aboutMe = docs.get('aboutMe');
    isRegistered = docs.get('isRegistered');
    isBarber = docs.get('isBarber');
  }

  Map<String, dynamic> toJSON() {
    final _data = <String, dynamic>{};
    _data['uid'] = uid;
    _data['phoneNumber'] = phoneNumber;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['email'] = email;
    _data['createdAt'] = createdAt;
    _data['dob'] = dob;
    _data['profileImage'] = profileImage;
    _data['aboutMe'] = aboutMe;
    _data['isRegistered'] = isRegistered;
    _data['isBarber'] = isBarber;

    return _data;
  }

  Map<String, dynamic> toJSONforUpdate() {
    final _data = <String, dynamic>{};
    uid != null ? _data['uid'] = uid : null;
    phoneNumber != null ? _data['phoneNumber'] = phoneNumber : null;
    firstName != null ? _data['firstName'] = firstName : null;
    lastName != null ? _data['lastName'] = lastName : null;
    email != null ? _data['email'] = email : null;
    dob != null ? _data['dob'] = dob : null;
    profileImage != null ? _data['profileImage'] = profileImage : null;
    aboutMe != null ? _data['aboutMe'] = aboutMe : null;
    isRegistered != null ? _data['isRegistered'] = isRegistered : null;
    isBarber != null ? _data['isBarber'] = isBarber : null;

    return _data;
  }
}
