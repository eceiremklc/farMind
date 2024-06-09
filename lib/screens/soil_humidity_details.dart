import 'package:flutter/material.dart';
import '../components/navbar.dart';
import '../components/soil_humidity_chart.dart';
import '../styles/detail_styles.dart';
import '../components/export_to_excel.dart';
import '../components/ortalama_deger.dart';
import '../components/min_max_hesapla.dart';

class SoilHumidityDetails extends StatelessWidget {
  final ExportToExcel exportToExcel = ExportToExcel();

  @override
  Widget build(BuildContext context) {
    String field = 'toprakNem';

    return FutureBuilder<Map<String, double?>>(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, double?>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Değerler hesaplanırken bir hata oluştu: ${snapshot.error}'));
        } else {
          double ortalamaToprakNem = snapshot.data?['ortalama'] ?? 0;
          double minToprakNem = snapshot.data?['min'] ?? 0;
          double maxToprakNem = snapshot.data?['max'] ?? 0;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Toprak Nemi Ölçümleri',
                style: DetailStyles.header,
              ),
            ),
            body: SafeArea(
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
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            exportToExcel.export();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xFFDFE4DD)),
                          ),
                          child: Text(
                            'Dışa Aktar: .xlsx',
                            style: DetailStyles.export,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 360,
                          height: 335,
                          decoration: BoxDecoration(
                            color: const Color(0xFFDFE4DD),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: SoilHumidityChart(),
                        ),
                        SizedBox(height: 15),
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
                                'Ortalama Toprak Nemi: ',
                                style: DetailStyles.avgwidget,
                              ),
                              SizedBox(width: 40),
                              Text(
                                '${ortalamaToprakNem.toStringAsFixed(2)}',
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
                                'Minimum Toprak Nemi: ',
                                style: DetailStyles.avgwidget,
                              ),
                              SizedBox(width: 40),
                              Text(
                                '${minToprakNem.toStringAsFixed(2)}',
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
                                'Maksimum Toprak Nemi: ',
                                style: DetailStyles.avgwidget,
                              ),
                              SizedBox(width: 40),
                              Text(
                                '${maxToprakNem.toStringAsFixed(2)}',
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

  Future<Map<String, double?>> _getData() async {
    double? avgToprakNem = await OrtalamaDeger().avgHesapla('toprakNem');
    double? minToprakNem = await MinMaxHesapla().minHesapla('toprakNem');
    double? maxToprakNem = await MinMaxHesapla().maxHesapla('toprakNem');
    return {'ortalama': avgToprakNem, 'min': minToprakNem, 'max': maxToprakNem};
  }
}