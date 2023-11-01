// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_getx_test/signup/signup_view_model.dart';
// import 'package:get/get.dart';
//
// class SignupView extends StatefulWidget {
//   const SignupView({super.key});
//
//   @override
//   State<SignupView> createState() => _SignupViewState();
// }
//
// class _SignupViewState extends State<SignupView> {
//   final SignupViewModel viewModel = Get.put(SignupViewModel());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: const Text("Signup"),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Form(
//             key: viewModel.formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 InkWell(
//                   onTap: () => viewModel.onImageClick(),
//                   child: CircleAvatar(
//                     backgroundColor: Colors.blue.withOpacity(0.3),
//                     maxRadius: 90,
//                     minRadius: 80,
//                     child: viewModel.selectedImage != null
//                         ? ClipRRect(
//                             borderRadius: BorderRadius.circular(90),
//                             child: Image.file(
//                               viewModel.selectedImage!,
//                               fit: BoxFit.cover,
//                             ),
//                           )
//                         : const Icon(
//                             Icons.person,
//                             size: 100,
//                           ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 myTextField(
//                   viewModel.emailController,
//                   "Email",
//                   "Enter Email",
//                   validator: (v) => viewModel.emailValidator(v),
//                 ),
//                 myTextField(
//                   viewModel.passwordController,
//                   "Password",
//                   "Password Controller",
//                   validator: (v) => viewModel.passwordValidator(v),
//                   isPassword: true,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 5),
//                   child: ElevatedButton(
//                     onPressed: () => viewModel.onSignUpTap(),
//                     child: const Text('SignUp'),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   child: RichText(
//                     text: TextSpan(
//                       children: [
//                         const TextSpan(
//                             text: 'Already have a Account ? ',
//                             style: TextStyle(color: Colors.black)),
//                         TextSpan(
//                             text: ' Login ',
//                             style: const TextStyle(
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.bold),
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = () {
//                                 Get.back();
//                               }),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   child: InkWell(
//                     onTap: () => viewModel.onGoogleTap(),
//                     child: Card(
//                       elevation: 4,
//                       child: Container(
//                         width: 200,
//                         padding: const EdgeInsets.all(6),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Row(
//                           children: [
//                             const Spacer(),
//                             Image.asset(
//                               'assets/images/google.png',
//                               width: 35,
//                               height: 35,
//                             ),
//                             const Spacer(),
//                             const Text(
//                               'SignUp With Google',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             const Spacer(),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget myTextField(
//       TextEditingController controller, String label, String hint,
//       {bool isPassword = false, String? Function(String?)? validator}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: TextFormField(
//         validator: validator,
//         keyboardType: isPassword ? TextInputType.emailAddress : null,
//         controller: controller,
//         obscureText: isPassword ? viewModel.isObscure.value : false,
//         decoration: InputDecoration(
//           suffixIcon: isPassword
//               ? GestureDetector(
//                   onTap: () => viewModel.onEyeTap(),
//                   child: viewModel.isObscure.value
//                       ? const Icon(
//                           Icons.visibility_off,
//                           color: Colors.black,
//                         )
//                       : const Icon(
//                           Icons.visibility,
//                           color: Colors.black,
//                         ))
//               : null,
//           labelText: label,
//           hintText: hint,
//           labelStyle: const TextStyle(color: Colors.black),
//           hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
//           border: InputBorder.none,
//           fillColor: Colors.black12,
//           filled: true,
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(
//               color: Colors.black,
//               width: 2,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
