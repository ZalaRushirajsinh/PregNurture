import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'authentication.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //Text Feild Controllers to get data from textfields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  //final userRepo = Get.put(UserRepository());

  //call this function from design and it will do the rest
  // void registerUser(String email, String password) {
  //   AuthenticationRepository.instance
  //       .createUserWithEmailAndPassword(email, password);
  // }

  //get phoneno from user and pass it to auth repository for firebase authentication
  // Future<void> createUser(UserModel user) async {
  //   await userRepo.createUser(user);
  //   phoneAuthentication(user.phoneNo);
  //   Get.to(() => OTPScreen());
  // }

  void phoneAuthentication(String phoneNo) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }
}
