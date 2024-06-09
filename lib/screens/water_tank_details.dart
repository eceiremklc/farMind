import 'package:flutter/material.dart';
import '../components/navbar.dart';
import '../components/ortalama_deger.dart';
import '../styles/detail_styles.dart';
import '../components/water_tank_chart.dart';
import '../components/min_max_hesapla.dart';

class WaterTankDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, double?>>(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, double?>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Değerler hesaplanırken bir hata oluştu: ${snapshot.error}'));
        } else {
          double ortalamaSuSeviyesi = snapshot.data?['ortalama'] ?? 0;
          double minSuSeviyesi = snapshot.data?['min'] ?? 0;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Su Deposu Doluluk Oranı',
                style: DetailStyles.header,
              ),
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
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 360,
                        height: 340,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDFE4DD),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: WaterTankChart(),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        padding: EdgeInsets.all(15),
                        height: 62,
                        width: 360,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDFE4DD),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Ortalama Su Seviyesi: ',
                              style: DetailStyles.avgwidget,
                            ),
                            SizedBox(width: 50),
                            Text(
                              '${ortalamaSuSeviyesi.toStringAsFixed(2)}',
                              style: DetailStyles.avgdata,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(15),
                        height: 62,
                        width: 360,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDFE4DD),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Minimum Su Seviyesi: ',
                              style: DetailStyles.avgwidget,
                            ),
                            SizedBox(width: 50),
                            Text(
                              '${minSuSeviyesi.toStringAsFixed(2)}',
                              style: DetailStyles.avgdata,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Navbar(),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<Map<String, double?>> _getData() async {
    double? avgSuSeviyesi = await OrtalamaDeger().avgHesapla('suSeviyesi');
    double? minSuSeviyesi = await MinMaxHesapla().minHesapla('suSeviyesi');
    return {'ortalama': avgSuSeviyesi, 'min': minSuSeviyesi};
  }
}
