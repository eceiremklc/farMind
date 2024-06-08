import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SoilHumidityChart extends StatefulWidget {
  const SoilHumidityChart({Key? key}) : super(key: key);

  @override
  _SoilHumidityChartState createState() => _SoilHumidityChartState();
}

class _SoilHumidityChartState extends State<SoilHumidityChart> {
  CollectionReference collectionRef =
  FirebaseFirestore.instance.collection('sensordata');

  List<ChartData> chartData = []; // chartData'yı boş liste olarak başlat
  double? averageSoilHumidity;

  @override
  void initState() {
    super.initState();
    getChartData();
  }

  Future<void> getChartData() async {
    try {
      // Firestore sorgusu (tarih filtresi kaldırıldı)
      QuerySnapshot querySnapshot = await collectionRef
          .orderBy('timestamp') // Zaman damgasına göre sırala
          .get();

      if (querySnapshot.docs.isEmpty) {
        print('Veri bulunamadı');
      } else {
        print('Veri başarıyla alındı');
      }

      // Veriyi eşleyin
      List<ChartData> data = querySnapshot.docs.map((doc) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        double y = map['toprakNem'].toDouble();
        DateTime timestamp = (map['timestamp'] as Timestamp).toDate();
        return ChartData(timestamp: timestamp, y: y);
      }).toList();

      // Durumu güncelle
      setState(() {
        chartData = data;
      });
    } catch (e) {
      print('Veri alınırken hata oluştu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Konteynerin genişliği doldurmasını sağlar
      height: double.infinity, // Konteynerin yüksekliği doldurmasını sağlar
      child: Center(
        // Grafiği konteynerin ortasına yerleştirir
        child: Container(
          width: 350,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: chartData.isEmpty
              ? Center(child: CircularProgressIndicator())
              : SfCartesianChart(
            primaryXAxis: DateTimeAxis(
              axisLine: AxisLine(
                  color: Colors.black, width: 1.5
              ),
              majorGridLines: MajorGridLines(
                color: Colors.black.withOpacity(0.3), // X ekseni büyük grid çizgi rengi
                width: 0.5, // X ekseni büyük grid çizgi kalınlığı
              ),
              minorGridLines: MinorGridLines(
                color: Colors.black.withOpacity(0.3), // X ekseni küçük grid çizgi rengi
                width: 0.5, // X ekseni küçük grid çizgi kalınlığı
              ),
              minorTicksPerInterval: 1, // Her büyük grid çizgisi arasında 4 küçük grid çizgisi
              interval: 5, // Büyük grid çizgileri arasındaki mesafe (örneğin, 1 gün)
            ),
            primaryYAxis: NumericAxis(
              axisLine: AxisLine(
                  color: Colors.black, width: 1.5
              ),
              majorGridLines: MajorGridLines(
                color: Colors.black.withOpacity(0.3), // Y ekseni büyük grid çizgi rengi
                width: 0.5, // Y ekseni büyük grid çizgi kalınlığı
              ),
              minorGridLines: MinorGridLines(
                color: Colors.black.withOpacity(0.3), // Y ekseni küçük grid çizgi rengi
                width: 0.5, // Y ekseni küçük grid çizgi kalınlığı
              ),
              minorTicksPerInterval: 1, // Her büyük grid çizgisi arasında 4 küçük grid çizgisi
              interval: 10, // Büyük grid çizgileri arasındaki mesafe (örneğin, 10 birim)
            ),
            series: <LineSeries<ChartData, DateTime>>[
              LineSeries<ChartData, DateTime>(
                color: Colors.black.withOpacity(0.7),
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.timestamp,
                yValueMapper: (ChartData data, _) => data.y,
                dataLabelSettings: DataLabelSettings(
                  isVisible: true, // Veri etiketlerini göster
                ),
                enableTooltip: true, // İpucu etkinleştir
                markerSettings: MarkerSettings(
                  borderWidth: 2.5,
                  borderColor: Colors.green,
                  color: Colors.white,
                  isVisible: true, // Noktaları göster
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  final DateTime timestamp;
  final double y;

  ChartData({required this.timestamp, required this.y});
}
