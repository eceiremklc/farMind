import 'package:farmind/screens/home.dart';
import 'package:farmind/styles/navbar_styles.dart';
import 'package:flutter/material.dart';
import './/screens/menu.dart';

class Navbar extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      width: 360,
      height: 62,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1E6),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
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
                  Icons.home_rounded,
                  color: const Color(0xFFa9a9a1),
                  size: 28,
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
                  Icons.menu_rounded,
                  color: const Color(0xFFa9a9a1),
                  size: 28,
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
                  color: const Color(0xFFa9a9a1),
                  size: 28,
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
                  Icons.settings_rounded,
                  color: const Color(0xFFa9a9a1),
                  size: 28,
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