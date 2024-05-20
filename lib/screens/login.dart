import 'package:farmind/screens/home.dart';
import 'package:farmind/screens/signup.dart';
import 'package:flutter/material.dart';
import '/styles/login_styles.dart';
import '/components/login_components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatelessWidget{

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _parolaController = TextEditingController();

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _parolaController.text,
      );

      // Giriş başarılı olduğunda yapılacak işlemler buraya gelebilir
      print('Giriş başarılı: ${userCredential.user!.uid}');
      _emailController.clear();
      _parolaController.clear();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()), // Anasayfa widget'ını buraya ekleyin
      );

    } catch (e) {
      // Giriş başarısız olduğunda yapılacak işlemler buraya gelebilir
      print('Giriş başarısız: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Giriş başarısız: $e'),
        ),
      );
    }
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFEFECE9),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Text(
                'Giriş Yap',
                style: LoginStyles.login_title,
              ),
              SizedBox(height: 50,),
              SizedBox(width: 335, height: 60,
                child: TextFormField(
                  controller: _emailController,
                  decoration: LoginComponents.email(),
                ),
              ),
              SizedBox(height: 15,),
              SizedBox(width: 335, height: 60,
                child: TextFormField(
                  controller: _parolaController,
                  obscureText: true,
                  decoration: LoginComponents.sifre(),
                ),
              ),
              SizedBox(height: 25,),
              SizedBox(width: 140, height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    _signInWithEmailAndPassword(context);
                  },
                  style: LoginStyles.login_button,
                  child: Text(
                    'Giriş Yap',
                    style: LoginStyles.button_text,
                  ),
                ),
              ),
              SizedBox(height: 30,),
              TextButton(
                onPressed: (){},
                child: Text(
                  'Şifremi Unuttum',
                  style: LoginStyles.tb_style,
                ),
              ),
              TextButton(
                onPressed: (){
                  Navigator.push(
                      context,
                    MaterialPageRoute(builder: (context) => SignUpPage()
                    ),
                  );
                },
                child: Text(
                  'Hesabınız yok mu? Kayıt Olun.',
                  style: LoginStyles.tb_style,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}