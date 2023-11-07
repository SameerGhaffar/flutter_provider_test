import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_test/auth/auth_provider.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late AuthProvider authProvider;
 @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Signup"),
        centerTitle: true,
      ),
      body: Consumer<AuthProvider>(builder: (context, value, child) {
        authProvider=value;
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: authProvider.signupformKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => authProvider.onImageClick(),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue.withOpacity(0.3),
                      maxRadius: 90,
                      minRadius: 80,
                      child: authProvider.selectedImage != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(90),
                        child: Image.file(
                          authProvider.selectedImage!,
                          fit: BoxFit.cover,
                        ),
                      )
                          : const Icon(
                        Icons.person,
                        size: 100,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  myTextField(
                    authProvider.emailController,
                    "Email",
                    "Enter Email",
                    validator: (v) => authProvider.emailValidator(v),
                  ),
                  myTextField(
                    authProvider.passwordController,
                    "Password",
                    "Password Controller",
                    validator: (v) => authProvider.passwordValidator(v),
                    isPassword: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ElevatedButton(
                      onPressed: () => authProvider.onSignUpTap(context),
                      child: const Text('SignUp'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              text: 'Already have a Account ? ',
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                              text: ' Login ',
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pop();
                                }),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      onTap: () => authProvider.onGoogleTap(),
                      child: Card(
                        elevation: 4,
                        child: Container(
                          width: 200,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Spacer(),
                              Image.asset(
                                'assets/images/google.png',
                                width: 35,
                                height: 35,
                              ),
                              const Spacer(),
                              const Text(
                                'SignUp With Google',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget myTextField(
      TextEditingController controller, String label, String hint,
      {bool isPassword = false, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        validator: validator,
        keyboardType: isPassword ? TextInputType.emailAddress : null,
        controller: controller,
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
