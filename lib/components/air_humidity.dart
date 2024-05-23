import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../styles/home_cards_styles.dart';

class AirHumidity extends StatefulWidget {
  @override
  _AirHumidityState createState() => _AirHumidityState();
}

class _AirHumidityState extends State<AirHumidity> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: EdgeInsets.only(left: 8, right: 8),
      width: 170,
      height: 160,
      decoration: BoxDecoration(
        color: const Color(0xFFD6E6E2),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          HomeCardsStyles.card_shadow,
        ],
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('sensordata').orderBy('timestamp', descending: true).limit(1).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Loading indicator while fetching data
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Text('No data available'); // If there's no data in Firestore
          }
          final data = snapshot.data!.docs.first.data() as Map<String, dynamic>?; // Extracting data from snapshot
          final humidity = data?['nem']; // Use null-aware operator to access 'nem'
          final timestamp = data?['timestamp'] as Timestamp?; // Assuming timestamp is stored in Firestore
          final formattedTimestamp = timestamp != null ? "${timestamp.toDate().hour}:${timestamp.toDate().minute}" : 'N/A'; // Extract hour and minute from timestamp
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Havadaki Nem Seviyesi:',
                softWrap: true,
                overflow: TextOverflow.visible,
                style: HomeCardsStyles.card_header,
              ),
              SizedBox(height: 7),
              Column(
                children: [
                  Text(
                    '%${humidity ?? 'N/A'}', // Display 'N/A' if humidity is null
                    style: HomeCardsStyles.card_data,
                  ),
                  SizedBox(height: 14),
                  Text(
                    'Son Ölçüm: $formattedTimestamp',
                    style: HomeCardsStyles.card_time,
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
