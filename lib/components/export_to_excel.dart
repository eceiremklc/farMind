import 'dart:io';
import 'package:excel/excel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ExportToExcel {
  Future<void> export(BuildContext context) async {
    // Request storage permissions
    if (!await _requestPermission(Permission.storage)) {
      print('Storage permission denied');
      return;
    }

    final collectionRef = FirebaseFirestore.instance.collection('sensordata');
    final query = collectionRef.orderBy('timestamp');
    final snapshot = await query.get();

    final excel = Excel.createExcel();
    Sheet sheet = excel['Sheet1'];

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

    // Use path_provider to get the documents directory
    Directory? appDocDir = await getExternalStorageDirectory();
    if (appDocDir == null) {
      print('Failed to get documents directory');
      return;
    }
    String targetDirectory = appDocDir.path;
    final filePath = '$targetDirectory/sensorVerileri.xlsx';

    List<int>? fileBytes = excel.save();
    if (fileBytes != null) {
      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes);

      print('File saved at: $filePath');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Dosya Kaydedildi'),
            content: Text('Dosya başarıyla kaydedildi. Dosyayı açmak ister misiniz?'),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  final result = await OpenFile.open(filePath);
                  print('OpenFile result: ${result.message}');
                },
                child: Text('Evet'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Hayır'),
              ),
            ],
          );
        },
      );
    } else {
      print('Hata: Excel dosyası kaydedilemedi.');
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      final result = await permission.request();
      return result.isGranted;
    }
  }
}
