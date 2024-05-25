import 'package:farmind/components/watering_switch.dart';
import 'package:farmind/screens/home.dart';
import 'package:farmind/screens/login.dart';
import 'package:farmind/screens/menu.dart';
import 'package:farmind/screens/signup.dart';
import 'package:farmind/screens/soil_humidity_details.dart';
import 'package:farmind/screens/start.dart';
import 'package:farmind/screens/temperature_details.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'components/sampleChart.dart';
import 'components/soil_humidity_chart.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load Turkish locale data
  await initializeDateFormatting('tr', '');
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('tr'), // Turkish
      ],
      locale: Locale('tr'), // Set Turkish as the default locale
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
