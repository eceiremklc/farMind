import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TemperatureChart extends StatefulWidget {
  const TemperatureChart({Key? key}) : super(key: key);

  @override
  _TemperatureChartState createState() => _TemperatureChartState();
}

class _TemperatureChartState extends State<TemperatureChart> {
  CollectionReference collectionRef =
  FirebaseFirestore.instance.collection('sensordata');

  late List<ChartData> chartData;

  @override
  void initState() {
    super.initState();
    getChartData();
  }

  Future<void> getChartData() async {
    QuerySnapshot querySnapshot =
    await collectionRef.orderBy('timestamp').get();
    List<ChartData> data = querySnapshot.docs.map((doc) {
      Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
      double y = map['sicaklikC'].toDouble();
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
          width: 390,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: chartData == null
              ? Center(child: CircularProgressIndicator())
              : SfCartesianChart(
            primaryXAxis: DateTimeAxis(),
            primaryYAxis: NumericAxis(),
            series: <LineSeries<ChartData, DateTime>>[
              LineSeries<ChartData, DateTime>(
                dataSource: chartData!,
                xValueMapper: (ChartData data, _) => data.timestamp,
                yValueMapper: (ChartData data, _) => data.y,
                dataLabelSettings: DataLabelSettings(
                  isVisible: true, // Veri etiketlerini göster
                ),
                enableTooltip: true, // İpucu etkinleştir
                markerSettings: MarkerSettings(
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
