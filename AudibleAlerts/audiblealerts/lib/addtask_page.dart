import 'package:audiblealerts/input_fields.dart';
import 'package:audiblealerts/main.dart';
import 'package:audiblealerts/showdate_picker.dart';
import 'package:audiblealerts/text_fields.dart';
import 'package:flutter/material.dart';
import "package:audiblealerts/appbar_style.dart";

class AddTaskPage extends StatefulWidget {
  final DateTime? selectedDate;
  final String? dropdownvalue, dropdownvalue2;
  final String? textfieldValue;
  final String data = "Iam";

  const AddTaskPage(
      {super.key,
      this.selectedDate,
      this.dropdownvalue,
      this.dropdownvalue2,
      this.textfieldValue});
  @override
  State<AddTaskPage> createState() {
    return _AddTaskPageState();
  }
}

class _AddTaskPageState extends State<AddTaskPage> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: const AppBarStyles("Add Task"),
      backgroundColor: Colors.white,
      body: const InputField(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 189, 82, 237),
        foregroundColor: Colors.white,
        onPressed: () {
          setState(
            () {
              MyHomePage(
                data: data,
              );
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

  String data = "I am";
}
