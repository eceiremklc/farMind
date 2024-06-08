import 'package:farmind/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/navbar.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFECE9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFECE9),
        title: Text(
          'Profilim',
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fon.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 130,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF5CB063)),
                          shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
                                (Set<MaterialState> states) {
                              return RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              );
                            },
                          ),
                        ),
                        child: Text(
                          textAlign: TextAlign.center,
                          'Bilgilerimi Düzenle',
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    SizedBox(
                      width: 200,
                      height: 130,
                      child: ElevatedButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => LoginPage(), // Giriş ekranı için LoginScreen yerine kendi ekranınızı ekleyin
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF008564)),
                          shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
                                (Set<MaterialState> states) {
                              return RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              );
                            },
                          ),
                        ),
                        child: Text(
                          textAlign: TextAlign.center,
                          'Çıkış Yap',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Navbar(),
            ],
          ),
        ],
      ),
    );
  }
}
