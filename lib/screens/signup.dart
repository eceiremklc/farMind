import 'package:farmind/components/signup_components.dart';
import 'package:farmind/screens/login.dart';
import 'package:farmind/styles/signup_styles.dart';
import 'package:flutter/material.dart';
import '/styles/login_styles.dart';
import '/components/login_components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatelessWidget{

  final TextEditingController _adController = TextEditingController();
  final TextEditingController _soyadController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _parolaController = TextEditingController();
  final TextEditingController _parolatController = TextEditingController();

  void _registerWithEmailAndPassword(BuildContext context) async {
    try {
      if(_parolaController.text != _parolatController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(
              'Parolalar eşleşmiyor!',
            ),)
        );
        return;
      }

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _parolaController.text,
      );

      String uid = userCredential.user!.uid;

      CollectionReference users = FirebaseFirestore.instance.collection('users');

      await users.doc(uid).set({
        'ad': _adController.text,
        'soyad': _soyadController.text,
        'tel': _telController.text,
        'email': _emailController.text,
      });

      print("Kullanıcı kaydedildi: $uid");

      _adController.clear();
      _soyadController.clear();
      _telController.clear();
      _emailController.clear();
      _parolaController.clear();
      _parolatController.clear();
    } catch (e) {
      print("Kayıt başarısız!: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Kayıt başarısız: $e"),
        ),
      );
    }
  }



  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFEFECE9),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 120,),
              Text(
                'Kayıt Ol',
                style: LoginStyles.login_title,
              ),
              SizedBox(height: 25,),
              SizedBox(width: 335, height: 60,
                child: TextFormField(
                  controller: _adController,
                  decoration: SignUpComponents.ad(),
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(width: 335, height: 60,
                child: TextFormField(
                  controller: _soyadController,
                  decoration: SignUpComponents.soyad(),
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(width: 335, height: 60,
                child: TextFormField(
                  controller: _telController,
                  decoration: SignUpComponents.tel(),
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(width: 335, height: 60,
                child: TextFormField(
                  controller: _emailController,
                  decoration: SignUpComponents.email(),
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(width: 335, height: 60,
                child: TextFormField(
                  controller: _parolaController,
                  obscureText: true,
                  decoration: SignUpComponents.parola(),
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(width: 335, height: 60,
                child: TextFormField(
                  controller: _parolatController,
                  obscureText: true,
                  decoration: SignUpComponents.parolat(),
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(height: 50, width: 140,
                child: ElevatedButton(
                  onPressed: () {
                    _registerWithEmailAndPassword(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  style: SignUpStyles.kayit_button,
                  child: Text(
                    'Kayıt Ol',
                    style: SignUpStyles.kayit_text,
                  ),
                ),
              ),
              SizedBox(height: 25,),
              TextButton(onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
                child: Text(
                  'Hesabınız var mı? Giriş yapın',
                  style: SignUpStyles.t_button,
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}