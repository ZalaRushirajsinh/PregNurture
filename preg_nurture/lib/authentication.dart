import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:preg_nurture/phone.dart';
import 'home_page.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  //will be load when app launches this func will be called and set the firebaseuser state
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  //setting initial screen onLoad
  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => MyPhone()) : Get.offAll(() => HomePage());
  }

  Future<void> phoneAuthentication(String phoneNo) async {
    // Format the phone number to remove non-numeric characters and add country code
    String formattedPhoneNumber =
        '+91' + phoneNo.replaceAll(RegExp(r'[^\d]'), '');

    await _auth.verifyPhoneNumber(
      phoneNumber: formattedPhoneNumber,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e) {
        if (e.code == "invalid-phone-number") {
          Get.snackbar('Error', 'The provided phone number is not valid.');
        } else {
          Get.snackbar('Error', 'Something went wrong. Please try again.');
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  Future<void> logout() async => await _auth.signOut();
}
