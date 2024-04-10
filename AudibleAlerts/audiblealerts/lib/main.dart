import "package:audiblealerts/addtask_page.dart";
import "package:flutter/material.dart";
import "package:audiblealerts/appbar_style.dart";
import "package:audiblealerts/model/ListDate.dart";
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  runApp(
    const AudibleAlerts(),
  );
}

class AudibleAlerts extends StatelessWidget {
  const AudibleAlerts({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  final dbHelper = DatabaseHelper();
  final DateTime? selectedDate;
  final String? textfieldValue, dropdownvalue, dropdownvalue2, data;
  MyHomePage(
      {super.key,
      this.selectedDate,
      this.textfieldValue,
      this.dropdownvalue,
      this.dropdownvalue2,
      this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarStyles("AudibleAlerts"),
      body: Center(
          child: Column(
        children: [
          TextButton(
            child: Text(
              textfieldValue.toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            onPressed: () {},
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const AddTaskPage(),
              ));
        },
      ),
    );
  }

  void _insertData() async {
    int result = await dbHelper.insertData(
        textfieldValue.toString(),
        DateTime.now().toIso8601String(),
        dropdownvalue2.toString(),
        dropdownvalue.toString());
    print('Inserted row id: $result');
  }

  void _retrieveData() async {
    List<Map<String, dynamic>> rows = await dbHelper.getData();
    rows.forEach((row) {
      print(
          'String value: ${row['stringValue']}, DateTime value: ${row['dateTimeValue']}');
    });
  }
}
