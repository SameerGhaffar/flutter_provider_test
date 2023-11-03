// import 'dart:io';
//
// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_getx_test/functions/funtions.dart';
// import 'package:flutter_getx_test/home/home_view.dart';
// import 'package:flutter_getx_test/services/auth_service.dart';
// import 'package:flutter_getx_test/services/storage_service.dart';
// import 'package:get/get.dart';
//
// class SignupViewModel extends GetxController {
//   final defaultProfilePicFile = File('assets/profile.jpg');
//   Rx<bool> isObscure = true.obs;
//   File? selectedImage;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   AuthService authService = AuthService();
//   StorageService storageService = StorageService();
//
//   void onEyeTap() {
//     isObscure.value = !isObscure.value;
//   }
//
//   String? emailValidator(String? value) {
//     String email = emailController.text.toString();
//     bool isValid = EmailValidator.validate(email);
//
//     if (value == null || value.isEmpty) {
//       return "Email is required";
//     } else if (!isValid) {
//       return "Please Enter Valid Email";
//     }
//
//     return null;
//   }
//
//   String? passwordValidator(String? value) {
//     if (value == null || value.isEmpty) {
//       return "Password is required";
//     }
//     if (value.length < 6) {
//       return "Password must be at least 6 characters long";
//     }
//     return null; // Return null if the input is valid
//   }
//
//   onSignUpTap() async {
//     if (formKey.currentState!.validate()) {
//       String email = emailController.text.toString();
//       String password = passwordController.text.toString();
//
//       bool isUserCreated = await authService.signup(email, password);
//       if (isUserCreated) {
//         emailController.clear();
//         passwordController.clear();
//         if (selectedImage != null) {
//           if (await storageService.uploadProfilePic(selectedImage!)) {
//             Get.to(const HomeView());
//           }
//         } else {
//           storageService.uploadProfilePic(defaultProfilePicFile);
//         }
//
//         // navigation
//       }
//     }
//   }
//
//   onGoogleTap() {
//     // bool isLogin = await AuthService().signUpWithGoogle();
//     // print("Islogin = $isLogin");
//     // if(isLogin){
//     //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Home(),),(route)=> false);
//     // }
//   }
//
//   onImageClick() async {
//     Functions functions = Functions();
//     selectedImage = await functions.pickImage();
//   }
// }
