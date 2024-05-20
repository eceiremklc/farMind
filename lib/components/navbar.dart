import 'package:farmind/screens/home.dart';
import 'package:farmind/styles/navbar_styles.dart';
import 'package:flutter/material.dart';
import './/screens/menu.dart';

class Navbar extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      width: 360,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFD1CEC5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Row(
        children: [
          Spacer(),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: Column(
              children: [
                Icon(
                  Icons.home,
                  color: const Color(0xFF12492F),
                  size:35,
                ),
                SizedBox(height: 2), // İkon ile metin arasına boşluk eklemek için
                Text(
                    'Anasayfa',
                    style: NavbarStyles.button_text
                ),
              ],
            ),
          ),
          Spacer(),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Menu()),
              );
            },
            child: Column(
              children: [
                Icon(
                  Icons.menu,
                  color: const Color(0xFF12492F),
                  size:35,
                ),
                SizedBox(height: 2), // İkon ile metin arasına boşluk eklemek için
                Text(
                    'Menü',
                    style: NavbarStyles.button_text
                ),
              ],
            ),
          ),
          Spacer(),
          TextButton(
            onPressed: () {
              // Butona tıklandığında yapılacak işlemler
            },
            child: Column(
              children: [
                Icon(
                  Icons.person,
                  color: const Color(0xFF12492F),
                  size:35,
                ),
                SizedBox(height: 2), // İkon ile metin arasına boşluk eklemek için
                Text(
                    'Profilim',
                    style: NavbarStyles.button_text
                ),
              ],
            ),
          ),
          Spacer(),
          TextButton(
            onPressed: () {
              // Butona tıklandığında yapılacak işlemler
            },
            child: Column(
              children: [
                Icon(
                  Icons.settings,
                  color: const Color(0xFF12492F),
                  size:35,
                ),
                SizedBox(height: 2), // İkon ile metin arasına boşluk eklemek için
                Text(
                    'Ayarlar',
                    style: NavbarStyles.button_text
                ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}