import 'dart:io';
import 'package:excel/excel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';


class ExportToExcel{
  Future <void> export() async{

    final collectionRef = FirebaseFirestore.instance.collection('sensordata');
    final query = collectionRef.orderBy('timestamp');
    final snapshot = await query.get();

    final excel = Excel.createExcel();
    Sheet sheet = excel['Veriler'];

    sheet.cell(CellIndex.indexByString('A1')).value = TextCellValue('Zaman Damgası');
    sheet.cell(CellIndex.indexByString('B1')).value = TextCellValue('Toprak Nemi');
    sheet.cell(CellIndex.indexByString('C1')).value = TextCellValue('Hava Sıcaklığı');
    sheet.cell(CellIndex.indexByString('D1')).value = TextCellValue('Hava Nemi');
    sheet.cell(CellIndex.indexByString('E1')).value = TextCellValue('Su Seviyesi');

    // Verileri hücrelere yazdır
    int row = 2;
    for (final document in snapshot.docs) {
      final timestamp = document.data()['timestamp'];
      final soilHumidity = document.data()['toprakNem'];
      final temperature = document.data()['sicaklikC'];
      final airHumidity = document.data()['nem'];
      final waterLevel = document.data()['suSeviyesi'];

      sheet.cell(CellIndex.indexByString('A$row')).value = TextCellValue(timestamp.toDate().toString());
      sheet.cell(CellIndex.indexByString('B$row')).value = TextCellValue(soilHumidity.toString());
      sheet.cell(CellIndex.indexByString('C$row')).value = TextCellValue(temperature.toString());
      sheet.cell(CellIndex.indexByString('D$row')).value = TextCellValue(airHumidity.toString());
      sheet.cell(CellIndex.indexByString('E$row')).value = TextCellValue(waterLevel.toString());

      row++;
    }

    final appDocDir = await getApplicationDocumentsDirectory();
    final filePath = '${appDocDir.path}/sensorVerileri.xlsx';

    List<int>? fileBytes = excel.save();
    if (fileBytes != null) {
      File(filePath)..createSync(recursive: true)..writeAsBytesSync(fileBytes);
      final uri = Uri.file(filePath); // Create a Uri from the file path
      await launchUrl(uri); // Launch the Uri using launchUrl
    } else {
      print('Hata: Excel dosyası kaydedilemedi.');
    }
  }
}