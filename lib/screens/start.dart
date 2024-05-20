import 'package:farmind/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../styles/animations.dart';
import '/styles/start_styles.dart';

class StartPage extends StatefulWidget{
  @override
  _StartPageState createState() => _StartPageState();
}
class _StartPageState extends State<StartPage> {
  @override
  @override
  void initState() {
    super.initState();
    // StartScreen açıldıktan sonra 3 saniye bekleyip ardından LoginScreen'e geçiş yap
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
            child: LoginPage(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 700)
        ),
      );
    });
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFF12492F),
      body: Center(
        child: Text(
          'farMind',
          style: StartStyles.start_title,
        ),
      ),
    );
  }
}