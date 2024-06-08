import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AirHumidityChart extends StatefulWidget {
  const AirHumidityChart({Key? key}) : super(key: key);

  @override
  _AirHumidityChartState createState() => _AirHumidityChartState();
}

class _AirHumidityChartState extends State<AirHumidityChart> {
  CollectionReference collectionRef =
  FirebaseFirestore.instance.collection('sensordata');

  late List<ChartData> chartData;

  @override
  void initState() {
    super.initState();
    getChartData();
  }

  Future<void> getChartData() async {
    // Get current date
    DateTime now = DateTime.now();

    // Set the starting date for the last two days
    DateTime twoDaysAgo = now.subtract(const Duration(days: 2));

    QuerySnapshot querySnapshot = await collectionRef
        .where('timestamp', isGreaterThanOrEqualTo: twoDaysAgo)
        .where('timestamp', isLessThanOrEqualTo: now)
        .orderBy('timestamp')
        .get();
    List<ChartData> data = querySnapshot.docs.map((doc) {
      Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
      double y = map['nem'].toDouble();
      DateTime timestamp = (map['timestamp'] as Timestamp).toDate();
      return ChartData(timestamp: timestamp, y: y);
    }).toList();
    setState(() {
      chartData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Wrap the chart with another Container to control its size
      width: double.infinity, // Ensures the container fills the width
      height: double.infinity, // Ensures the container fills the height
      child: Center(
        // Center the chart within the container
        child: Container(
          width: 350,
          height: 280,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: chartData == null
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
                color: Colors.black.withOpacity(0.3), // X ekseni büyük grid çizgi rengi
                width: 0.5, // X ekseni büyük grid çizgi kalınlığı
              ),
              minorGridLines: MinorGridLines(
                color: Colors.black.withOpacity(0.3), // X ekseni küçük grid çizgi rengi
                width: 0.5, // X ekseni küçük grid çizgi kalınlığı
              ),
              minorTicksPerInterval: 1, // Her büyük grid çizgisi arasında 4 küçük grid çizgisi
              interval: 10, // Büyük grid çizgileri arasındaki mesafe (örneğin, 10 birim)
            ),
            series: <LineSeries<ChartData, DateTime>>[
              LineSeries<ChartData, DateTime>(
                color: Colors.black.withOpacity(0.7),
                dataSource: chartData!,
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
