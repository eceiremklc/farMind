import 'package:farmind/components/watering_switch.dart';
import 'package:farmind/styles/home_cards_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WateringCard extends StatefulWidget {
  @override
  _WateringCardState createState() => _WateringCardState();
}

class _WateringCardState extends State<WateringCard> {
  String _formattedTimestamp = ""; // Initialize with an empty string

  @override
  void initState() {
    super.initState();
    _fetchLastWateringTime(); // Fetch data on widget initialization
  }

  Future<void> _fetchLastWateringTime() async {
    final firestore = FirebaseFirestore.instance;

    // Get a reference to the 'su' collection and the 'zaman' document
    final docRef = firestore.collection('su').doc('zaman');

    try {
      final docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        final Map<String, dynamic> data = docSnapshot.data()!;
        // Extract hour and minute values (assuming data structure)
        final int hour = data['saat']; // Replace with actual field name if different
        final int minute = data['dakika']; // Replace with actual field name if different

        // Format the timestamp as desired
        _formattedTimestamp = _formatTime(hour, minute);
        setState(() {}); // Update state to trigger UI rebuild
      } else {
        print('Document does not exist');
        // Handle case where document is not found (optional)
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Handle errors appropriately (optional)
    }
  }

  String _formatTime(int hour, int minute) {
    String formattedHour = hour.toString().padLeft(2, '0');
    String formattedMinute = minute.toString().padLeft(2, '0');
    return '$formattedHour:$formattedMinute';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WateringSwitch()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.all(8),
        width: 355,
        height: 75,
        decoration: BoxDecoration(
          color: const Color(0xFFC1D95C),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            HomeCardsStyles.card_shadow,
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Son Sulama:',
              style: HomeCardsStyles.last_watering_header,
            ),
            SizedBox(height: 5),
            Text(
              _formattedTimestamp, // Display fetched timestamp
              style: HomeCardsStyles.last_watering_time,
            ),
          ],
        ),
      ),
    );
  }
}
