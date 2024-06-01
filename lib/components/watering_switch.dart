import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WateringSwitch extends StatefulWidget {
  @override
  _WateringSwitchState createState() => _WateringSwitchState();
}

class _WateringSwitchState extends State<WateringSwitch> {
  bool _switchValue = false; // Use "_" for private variables

  @override
  void initState() {
    super.initState();
    _getInitialSwitchValue();
  }

  Future<void> _getInitialSwitchValue() async {
    // Firestore'dan başlangıç durumunu çek
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('su').doc('motor').get();
    setState(() {
      _switchValue = doc['durum'];
    });
  }

  Future<void> _updateSwitchValue(bool newValue) async {
    // Firestore'da durumu güncelle
    await FirebaseFirestore.instance.collection('su').doc('motor').update({'durum': newValue});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sulama Sistemi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 1.5, // Adjust this value to change the size of the switch
              child: Switch(
                value: _switchValue,
                onChanged: (value) async {
                  setState(() {
                    _switchValue = value;
                  });
                  await _updateSwitchValue(value);
                },
                materialTapTargetSize: MaterialTapTargetSize.padded, // Use the existing enum value
                trackColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.blue; // Active track color
                  }
                  return Colors.grey; // Inactive track color
                }),
                thumbColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.blueAccent; // Active thumb color
                  }
                  return Colors.grey; // Inactive thumb color
                }),
                inactiveTrackColor: Colors.white, // Inactive track color
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _switchValue ? 'Sulama Açık' : 'Sulama Kapalı',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}