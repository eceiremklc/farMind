import 'package:farmind/screens/temperature_details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../styles/home_cards_styles.dart';

class TemperatureCard extends StatefulWidget {
  @override
  _TemperatureCardState createState() => _TemperatureCardState();
}

class _TemperatureCardState extends State<TemperatureCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Kart bileşenine tıklandığında yapılacak işlemler
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TemperatureDetails()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(11),
        margin: EdgeInsets.only(left: 8, right: 8),
        width: 170,
        height: 130,
        decoration: BoxDecoration(
          color: const Color(0xFF80B155),
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
            final temperature = data?['sicaklikC']; // Use null-aware operator to access 'nem'
            final timestamp = data?['timestamp'] as Timestamp?; // Assuming timestamp is stored in Firestore
            final formattedTimestamp = timestamp != null ? DateFormat('HH.mm').format(timestamp.toDate()) : 'N/A'; // Extract hour and minute from timestamp
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Ölçülen Sıcaklık:',
                  style: HomeCardsStyles.card_header,
                ),
                SizedBox(height: 13),
                Column(
                  children: [
                    Text(
                      '${temperature ?? 'N/A'}°C', // Display 'N/A' if humidity is null
                      style: HomeCardsStyles.card_data,
                    ),
                    SizedBox(height: 6),
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
      ),
    );
  }
}
