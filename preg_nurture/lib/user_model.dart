class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;

  const UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.phoneNo,
    required this.fullName,
  });

  // toJson() {
  //   return {
  //     "FullName": fullName,
  //     "Email": email,
  //     "Phone": phoneNo,
  //     "Password": password,
  //   };
  // }

  // mapping user fetched from firebase to usermodel

  // factory UserModel.fromSnapshot(
  //     DocumentSnapshot<Map<String, dynamic>> document) {
  //   final data = document.data()!;
  //   return UserModel(
  //     id: document.id,
  //     email: data["Email"],
  //     password: data["Password"],
  //     phoneNo: data["Phone"],
  //     fullName: data["FullName"],
  //   );
  // }
}
