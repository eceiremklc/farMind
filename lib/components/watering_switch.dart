import 'package:farmind/components/humidity_card.dart';
import 'package:farmind/components/water_tank.dart';
import 'package:farmind/styles/detail_styles.dart';
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
    DocumentSnapshot doc =
    await FirebaseFirestore.instance.collection('su').doc('motor').get();
    setState(() {
      _switchValue = doc['durum'];
    });
  }

  Future<void> _updateSwitchValue(bool newValue) async {
    // Firestore'da durumu güncelle
    await FirebaseFirestore.instance
        .collection('su')
        .doc('motor')
        .update({'durum': newValue});
  }

  Future<void> _openChangeTimeDialog() async {
    // Sulama zamanını değiştirmek için AlertDialog'u aç
    await showDialog(
      context: context,
      builder: (context) => SulamaZamaniDegistir(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sulama Sistemi'),
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fon.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WaterTank(),
                    SizedBox(width: 4),
                    HumidityCard(),
                  ],
                ),
                SizedBox(height: 30),
                Center(
                  child: Container(
                    width: 360,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color(0xFF12492F),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.scale(
                          scale:
                          1.5, // Adjust this value to change the size of the switch
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Switch(
                                value: _switchValue,
                                onChanged: (value) async {
                                  setState(() {
                                    _switchValue = value;
                                  });
                                  await _updateSwitchValue(value);
                                },
                                materialTapTargetSize:
                                MaterialTapTargetSize
                                    .padded, // Use the existing enum value
                                trackColor: MaterialStateProperty.resolveWith(
                                        (states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return Colors
                                            .lightGreen; // Active track color
                                      }
                                      return const Color(
                                          0xFFD1CEC5); // Inactive track color
                                    }),
                                thumbColor:
                                MaterialStateProperty.resolveWith((states) {
                                  if (states
                                      .contains(MaterialState.selected)) {
                                    return const Color(
                                        0xFF12492F); // Active thumb color
                                  }
                                  return const Color(
                                      0xFF1E1E1E); // Inactive thumb color
                                }),
                                inactiveTrackColor:
                                const Color(0xFFD1CEC5), // Inactive track color
                              ),
                              const SizedBox(width: 50),
                              Text(
                                _switchValue ? 'Sulama Açık' : 'Sulama Kapalı',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Nunito',
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                  ),
                  onPressed: _openChangeTimeDialog,
                  child: Text(
                    'Otomatik Sulama Zamanını Değiştir',
                    style: DetailStyles.avgwidget,
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SulamaZamaniDegistir extends StatefulWidget {
  @override
  _SulamaZamaniDegistirState createState() => _SulamaZamaniDegistirState();
}

class _SulamaZamaniDegistirState extends State<SulamaZamaniDegistir> {
  TimeOfDay _selectedTime = TimeOfDay.now(); // Başlangıçta seçilen saat

  Future<void> _updateSulamaZamani() async {
    // Firestore'da zaman dokümanını güncelle
    await FirebaseFirestore.instance
        .collection('su')
        .doc('zaman')
        .set({'saat': _selectedTime.hour, 'dakika': _selectedTime.minute});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sulama Zamanını Değiştir'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Saat Seç'),
              trailing: Text(
                '${_selectedTime.hour}:${_selectedTime.minute}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                );
                if (pickedTime != null) {
                  setState(() {
                    _selectedTime = pickedTime;
                  });
                }

                if (pickedTime != null) {
                  setState(() {
                    _selectedTime = pickedTime;
                  });
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _updateSulamaZamani();
                Navigator.of(context).pop();
              },
              child: Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}