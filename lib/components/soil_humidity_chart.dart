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
      double y = map['toprakNem'].toDouble();
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
          height: 200,
          decoration: BoxDecoration(
            color: const Color(0xFFFCF9F5),
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
                      width: 1, // X ekseni büyük grid çizgi kalınlığı
                    ),
                    minorGridLines: MinorGridLines(
                      color: Colors.black.withOpacity(0.3), // X ekseni küçük grid çizgi rengi
                      width: 0.5, // X ekseni küçük grid çizgi kalınlığı
                    ),
                  ),

                  primaryYAxis: NumericAxis(
                    axisLine: AxisLine(
                        color: Colors.black, width: 1.5
                    ),
                    majorGridLines: MajorGridLines(
                      color: Colors.black.withOpacity(0.3), // X ekseni büyük grid çizgi rengi
                      width: 1, // X ekseni büyük grid çizgi kalınlığı
                    ),
                    minorGridLines: MinorGridLines(
                      color: Colors.black.withOpacity(0.3), // X ekseni küçük grid çizgi rengi
                      width: 0.5, // X ekseni küçük grid çizgi kalınlığı
                    ),
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
