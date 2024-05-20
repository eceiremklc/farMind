import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HumidityCard extends StatefulWidget {
  @override
  _HumidityCardState createState() => _HumidityCardState();
}

class _HumidityCardState extends State<HumidityCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: 185,
      height: 160,
      decoration: BoxDecoration(
        color: const Color(0xFF88B259),
        borderRadius: BorderRadius.circular(20),
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
                'Nem Seviyesi:',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF12492F),
                ),
              ),
              SizedBox(height: 5),
              Column(
                children: [
                  Text(
                    '%${humidity ?? 'N/A'}', // Display 'N/A' if humidity is null
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 40,
                      color: const Color(0xFF12492F),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Son Ölçüm: $formattedTimestamp',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 16,
                      color: const Color(0xFF12492F),
                    ),
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
