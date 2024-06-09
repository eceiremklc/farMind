import 'package:flutter/material.dart';
import '../components/navbar.dart';
import '../components/ortalama_deger.dart';
import '../components/min_max_hesapla.dart'; // MinMaxHesapla sınıfı eklendi
import '../components/air_humidity_chart.dart';
import '../styles/detail_styles.dart';

class AirHumidityDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, double?>>(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, double?>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoading(); // Veriler yüklenirken bekletme ekranı
        } else if (snapshot.hasError) {
          return _buildError(snapshot.error.toString()); // Hata durumunda hata mesajını gösterme
        } else {
          double ortalamaHavaNemi = snapshot.data?['ortalama'] ?? 0; // Ortalama değeri kullan, yoksa 0 kullan
          double minHavaNemi = snapshot.data?['min'] ?? 0; // Minimum değeri kullan, yoksa 0 kullan
          return Scaffold(
            backgroundColor: const Color(0xFFEFECE9),
            appBar: AppBar(
              title: Text(
                'Hava Nemi Ölçümleri',
                style: DetailStyles.header,
              ),
              backgroundColor: const Color(0xFFEFECE9),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                await _getData();
              },
              child: Stack(
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
                          child: AirHumidityChart(),
                        ),
                        SizedBox(height: 20),
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
                                'Ortalama Hava Nemi: ',
                                style: DetailStyles.avgwidget,
                              ),
                              SizedBox(width: 60),
                              Text(
                                '${ortalamaHavaNemi.toStringAsFixed(2)}',
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
                                'Minimum Hava Nemi: ',
                                style: DetailStyles.avgwidget,
                              ),
                              SizedBox(width: 60),
                              Text(
                                '${minHavaNemi.toStringAsFixed(2)}',
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
            ),
          );
        }
      },
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(String errorMessage) {
    return Center(
      child: Text('Veriler alınırken bir hata oluştu: $errorMessage'),
    );
  }

  Future<Map<String, double?>> _getData() async {
    String field = 'nem'; // Alan adı
    double? avgHumidity = await OrtalamaDeger().avgHesapla(field); // Ortalama nem değeri
    double? minHumidity = await MinMaxHesapla().minHesapla(field); // Minimum nem değeri
    return {'ortalama': avgHumidity, 'min': minHumidity};
  }
}
