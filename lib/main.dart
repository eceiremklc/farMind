import 'package:farmind/screens/home.dart';
import 'package:farmind/screens/login.dart';
import 'package:farmind/screens/menu.dart';
import 'package:farmind/screens/signup.dart';
import 'package:farmind/screens/start.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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
      title: 'FarMind',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
        useMaterial3: true,
      ),
      home: HomePage(),
      /*initialRoute: '/',
      routes: {
        '/': (context) =>  LoginPage(),
        '/signup': (context) =>  SignUpPage(),
        '/home': (context) =>  HomePage(),
        '/menu': (context) =>  Menu(),
      },*/
    );
  }
}
