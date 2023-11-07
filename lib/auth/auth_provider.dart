import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_test/functions/funtions.dart';
import 'package:flutter_provider_test/services/auth_service.dart';
import 'package:flutter_provider_test/services/storage_service.dart';
import 'package:flutter_provider_test/ui/home/home_view.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  final defaultProfilePicFile = File('assets/profile.jpg');
  bool isObscure = true;
  File? selectedImage;
  final GlobalKey<FormState> signupformKey = GlobalKey<FormState>();

  final GlobalKey<FormState> loginformKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthService authService = AuthService();
  StorageService storageService = StorageService();

  void onEyeTap() {
    isObscure = !isObscure;
    notifyListeners();
  }

  String? emailValidator(String? value) {
    String email = emailController.text.toString();
    bool isValid = EmailValidator.validate(email);

    if (value == null || value.isEmpty) {
      return "Email is required";
    } else if (!isValid) {
      return "Please Enter Valid Email";
    }

    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null; // Return null if the input is valid
  }

  onGoogleTap() {
    // bool isLogin = await AuthService().signUpWithGoogle();
    // print("Islogin = $isLogin");
    // if(isLogin){
    //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Home(),),(route)=> false);
    // }
  }

  onImageClick() async {
    Functions functions = Functions();
    selectedImage = await functions.pickImage();
  }


  onSignUpTap(BuildContext context) async {
    if (signupformKey.currentState!.validate()) {
      String email = emailController.text.toString();
      String password = passwordController.text.toString();

      bool isUserCreated = await signupWithApi(email, password);
      if (isUserCreated) {
        emailController.clear();
        passwordController.clear();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const HomeView(),
            ),
                (route) => false);
        print('User Logined');
      } else {}
    }
  }

  signupWithApi(String email, String password) async {
    try {
      http.Response response = await http.post(
        Uri.parse("https://reqres.in/api/register"),
        body: {'email': email, 'password': password},
      );
      var data = jsonDecode(response.body.toString());
      print(data['token']);
      if (response.statusCode == 200) {
        print("Account signUp Successfully");
        return true;
      } else {
        print("Account not signup");
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  loginWithApi(String email, String password) async {
    try {
      http.Response response = await http.post(
        Uri.parse("https://reqres.in/api/login"),
        body: {'email': email, 'password': password},
      );

      var data = jsonDecode(response.body.toString());
      print(data['token']);
      if (response.statusCode == 200) {
        print("Account logined Successfully");
        return true;
      } else {
        print("Account not logined");
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  onLoginTap(BuildContext context) async {
    if (loginformKey.currentState!.validate()) {
      String password = passwordController.text.toString();
      String email = emailController.text.toString();

      bool isUserLogin = await loginWithApi(email, password);
      if (isUserLogin) {
        emailController.clear();
        passwordController.clear();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const HomeView(),
            ),
                (route) => false);
        print('User Logined');
      } else {}
    }
  }

}
