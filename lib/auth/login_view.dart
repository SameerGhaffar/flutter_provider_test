import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_test/auth/auth_provider.dart';
import 'package:flutter_provider_test/auth/signup_view.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {



  late AuthProvider authProvider;
  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
  }
  @override
  void dispose() {
    super.dispose();
    authProvider.emailController.dispose();
    authProvider.passwordController.dispose();
    authProvider.isObscure=true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Consumer<AuthProvider>(builder: (context, value, child) {
        return Form(
          key: authProvider.loginformKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildTextField(
                authProvider.emailController,
                "Email",
                "Enter Email",
                validator: (v) => authProvider.emailValidator(v),
              ),
              buildTextField(
                authProvider.passwordController,
                "Password",
                "Enter Password",
                isPassword: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 10),
                child: ElevatedButton(
                  onPressed: () => authProvider.onLoginTap(context),
                  child: const Text('Login'),
                ),
              ),
              RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                        text: 'Need an Account ? ',
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: ' SignUp Now ',
                        style: const TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignupView(),));

                          }),
                  ])),
            ],
          ),
        );
      },),
    );
  }

  Widget buildTextField(
      TextEditingController emailController, String label, String hint,
      {bool isPassword = false, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: TextFormField(
        validator: validator,
        keyboardType: isPassword ? TextInputType.emailAddress : null,
        controller: emailController,
        obscureText: isPassword ? authProvider.isObscure : false,
        decoration: InputDecoration(
          suffixIcon: isPassword
              ? GestureDetector(
                  onTap: () => authProvider.onEyeTap(),
                  child: authProvider.isObscure
                      ? const Icon(
                          Icons.visibility_off,
                          color: Colors.black,
                        )
                      : const Icon(
                          Icons.visibility,
                          color: Colors.black,
                        ))
              : null,
          labelText: label,
          hintText: hint,
          labelStyle: const TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
          border: InputBorder.none,
          fillColor: Colors.black12,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }


}
