import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class OrtalamaDeger{
  Future<double> avgHesapla(String field) async {
    final collectionRef = FirebaseFirestore.instance.collection('sensordata');
    final query = collectionRef.get();
    final snapshot = await query;
    double toplamDeger = 0;
    int documentSayisi = 0;

    for (final document in snapshot.docs) {
      final deger = document[field];

      if (deger != null) {
        toplamDeger += deger;
        documentSayisi++;
      }
    }

    if (documentSayisi == 0) {
      throw Exception('Herhangi bir belge bulunamadı!');
    }

    double ortalamaDeger = toplamDeger / documentSayisi;
    return ortalamaDeger;
  }
}