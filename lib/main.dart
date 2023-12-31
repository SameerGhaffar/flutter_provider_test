import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_test/auth/auth_provider.dart';
import 'package:flutter_provider_test/auth/login_view.dart';
import 'package:flutter_provider_test/firebase_options.dart';
import 'package:flutter_provider_test/ui/home/home_view.dart';
import 'package:flutter_provider_test/ui/profile/profile_provider.dart';
import 'package:flutter_provider_test/ui/todo/todo_view.dart';
import 'package:flutter_provider_test/ui/todo/todo_view_model.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoViewModel()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider(),)
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeView(),
    );
  }
}
