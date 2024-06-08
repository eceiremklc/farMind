import 'package:flutter/material.dart';
import '../components/navbar.dart';
import '../components/soil_humidity_chart.dart';
import '../styles/detail_styles.dart';

class SoilHumidityDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFFEFECE9),
      appBar: AppBar(
        title: Text(
          'Toprak Nemi Ölçümleri',
          style: DetailStyles.header,
        ),
        //backgroundColor: const Color(0xFFEFECE9),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFFDFE4DD)),
              ),
              child: Text(
                'Dışa Aktar: .xlsx',
                style: DetailStyles.export,
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: 360,
              height: 335, // Yüksekliği arttırıldı
              decoration: BoxDecoration(
                color: const Color(0xFFDFE4DD),
                borderRadius: BorderRadius.circular(25),
              ),
              child: SoilHumidityChart(),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.all(15),
              height: 80,
              width: 360,
              decoration: BoxDecoration(
                color: const Color(0xFFDFE4DD),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(children: [
                Text(
                  'Ortalama Toprak Nemi: ',
                  style: DetailStyles.avgwidget,
                ),
                SizedBox(width: 50,),
                Text(
                  '48,25',
                  style: DetailStyles.avgdata,
                ),
              ]),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}
