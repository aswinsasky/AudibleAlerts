import 'package:audiblealerts/input_fields.dart';
import 'package:audiblealerts/main.dart';
import 'package:audiblealerts/showdate_picker.dart';
import 'package:audiblealerts/text_fields.dart';
import 'package:flutter/material.dart';
import "model/ListDate.dart";

late List<Map<String, dynamic>> data;
final dbHelper = DatabaseHelper();
void _retrieveData() async {
  data = await dbHelper.getData();
}

class AddTaskPage extends StatefulWidget {
  final DateTime? selectedDate;
  final String? dropdownvalue, dropdownvalue2;
  final String? textfieldValue;

  AddTaskPage(
      {super.key,
      this.selectedDate,
      this.dropdownvalue,
      this.dropdownvalue2,
      this.textfieldValue}) {
    _retrieveData();
  }
  @override
  State<AddTaskPage> createState() {
    return _AddTaskPageState();
  }
}

class _AddTaskPageState extends State<AddTaskPage> {
  final dbHelper = DatabaseHelper();
  void _insertData(int id) async {
    int result = await dbHelper.insertData(
        id,
        textfieldValue.toString(),
        selectedDate.toString(),
        dropdownvalue2.toString(),
        dropdownvalue.toString());
    print('Inserted row id: $result');
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 189, 85, 253),
        title: const Padding(
          padding: EdgeInsets.only(
            left: 0,
            top: 0,
          ),
          child: Text(
            "Add Task",
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: const InputField(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 189, 82, 237),
        foregroundColor: Colors.white,
        onPressed: () {
          setState(
            () {
              _retrieveData();
              _insertData(data.length);
              MyHomePage();
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return MyHomePage(
                      selectedDate: selectedDate,
                      dropdownvalue2: dropdownvalue2,
                      dropdownvalue: dropdownvalue,
                      textfieldValue: textfieldValue);
                },
              ));
            },
          );
        },
        child: const Icon(Icons.check_outlined),
      ),
    );
  }
}
