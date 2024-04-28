import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:puskesmas_cisadea/auth/auth_gate.dart';
import 'package:puskesmas_cisadea/auth/login.dart';
import 'package:puskesmas_cisadea/auth/register.dart';
import 'package:puskesmas_cisadea/user/home.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const AuthGate(),
        '/login':(context) => Login(),
        '/register':(context) => Register(),
        '/home': (context) => Home(),
      },
    );
  }
}
