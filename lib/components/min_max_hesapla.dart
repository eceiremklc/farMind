import 'package:cloud_firestore/cloud_firestore.dart';

class MinMaxHesapla {
  Future<double?> minHesapla(String field) async {
    final collectionRef = FirebaseFirestore.instance.collection('sensordata');
    final query = collectionRef.orderBy(field, descending: false).limit(1);

    final snapshot = await query.get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    final DocumentSnapshot doc = snapshot.docs[0];
    final dynamic value = doc.get(field);
    if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else {
      return null;
    }
  }

  Future<double?> maxHesapla(String field) async {
    final collectionRef = FirebaseFirestore.instance.collection('sensordata');
    final query = collectionRef.orderBy(field, descending: true).limit(1);

    final snapshot = await query.get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    final DocumentSnapshot doc = snapshot.docs[0];
    final dynamic value = doc.get(field);
    if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else {
      return null;
    }
  }

}
