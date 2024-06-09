import 'package:flutter/material.dart';
import '../components/navbar.dart';
import '../components/temperature_chart.dart';
import '../styles/detail_styles.dart';
import '../components/ortalama_deger.dart';
import '../components/min_max_hesapla.dart';

class TemperatureDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, double?>>(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, double?>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoading(); // Ortalama, min ve max değerler hesaplanırken bekletme ekranı
        } else if (snapshot.hasError) {
          return _buildError(snapshot.error.toString()); // Hata durumunda hata mesajını gösterme
        } else {
          double ortalamaSicaklik = snapshot.data?['ortalama'] ?? 0; // Ortalama sıcaklık değeri kullan, yoksa 0 kullan
          double minSicaklik = snapshot.data?['min'] ?? 0; // Minimum sıcaklık değeri kullan, yoksa 0 kullan
          double maxSicaklik = snapshot.data?['max'] ?? 0; // Maksimum sıcaklık değeri kullan, yoksa 0 kullan
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Sıcaklık Ölçümleri',
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
                SafeArea(
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          width: 360,
                          height: 330,
                          decoration: BoxDecoration(
                            color: const Color(0xFFDFE4DD),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TemperatureChart(),
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
                                'Ortalama Hava Sıcaklığı: ',
                                style: DetailStyles.avgwidget,
                              ),
                              SizedBox(width: 40),
                              Text(
                                '${ortalamaSicaklik.toStringAsFixed(2)}',
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
                                'Minimum Hava Sıcaklığı: ',
                                style: DetailStyles.avgwidget,
                              ),
                              SizedBox(width: 40),
                              Text(
                                '${minSicaklik.toStringAsFixed(2)}',
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
                                'Maksimum Hava Sıcaklığı: ',
                                style: DetailStyles.avgwidget,
                              ),
                              SizedBox(width: 40),
                              Text(
                                '${maxSicaklik.toStringAsFixed(2)}',
                                style: DetailStyles.avgdata,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(String errorMessage) {
    return Center(
      child: Text('Ortalama, minimum ve maksimum değerler hesaplanırken bir hata oluştu: $errorMessage'),
    );
  }

  Future<Map<String, double?>> _getData() async {
    String field = 'sicaklikC'; // Alan adı
    double? avgTemperature = await OrtalamaDeger().avgHesapla(field); // Ortalama sıcaklık değeri
    double? minTemperature = await MinMaxHesapla().minHesapla(field); // Minimum sıcaklık değeri
    double? maxTemperature = await MinMaxHesapla().maxHesapla(field); // Maksimum sıcaklık değeri
    return {'ortalama': avgTemperature, 'min': minTemperature, 'max': maxTemperature};
  }
}
