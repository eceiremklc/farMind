import 'package:farmind/components/watering_switch.dart';
import 'package:farmind/styles/home_cards_styles.dart';
import 'package:flutter/material.dart';

class WateringCard extends StatefulWidget {
  @override
  _WateringCardState createState() => _WateringCardState();
}

class _WateringCardState extends State<WateringCard> {
  @override
  Widget build(BuildContext context) {
    final formattedTimestamp = "14:30"; // Örnek zaman damgası

    return GestureDetector(
      onTap: () {
        // Kart bileşenine tıklandığında yapılacak işlemler
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
                style: HomeCardsStyles.last_watering_header
            ),
            SizedBox(height: 5),
            Text(
              ' $formattedTimestamp', // Sabit zaman damgası
              style: HomeCardsStyles.last_watering_time,
            ),
          ],
        ),
      ),
    );
  }
}
