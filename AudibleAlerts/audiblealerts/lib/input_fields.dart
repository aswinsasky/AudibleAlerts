import 'package:audiblealerts/addtask_page.dart';
import 'package:audiblealerts/text_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:audiblealerts/time_picker.dart";
import "package:audiblealerts/showdate_picker.dart";
import 'package:flutter/widgets.dart';

const List<String> list = <String>[
  "2 minutes",
  "5 minutes",
  "No Snooze",
];
const List<String> list2 = <String>[
  "Daily",
  "Monthly",
  "Do not Repeat",
];
String dropdownvalue = list.first;
String dropdownvalue2 = list2.first;

class InputField extends StatefulWidget {
  final DateTime? selectedDate;
  final String? textfieldValue;
  const InputField({super.key, this.selectedDate, this.textfieldValue});

  @override
  State<InputField> createState() {
    return _InputFieldState();
  }
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Row(
          children: [
            Expanded(child: TextFieldStyle()),
          ],
        ),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 0,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              bottom: BorderSide(
                  width: 0, color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
          height: 65,
          width: double.infinity,
          child: const Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: DatePickerButton(),
              ),
              TimePickerButton()
            ],
          ),
        ),
        Row(
          children: [
            const Text(
              "Select Snooze Time  ",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 20),
            ),
            SizedBox(
              child: DropdownButton(
                value: dropdownvalue,
                hint: const Text("Select Snooze Time"),
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (String? value) {
                  setState(
                    () {
                      dropdownvalue = value!;
                      AddTaskPage(dropdownvalue: dropdownvalue);
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              "Repeat Frequency     ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            DropdownButton(
              value: dropdownvalue2,
              hint: const Text("Select Snooze Time"),
              items: list2.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
              onChanged: (String? value) {
                setState(
                  () {
                    dropdownvalue2 = value!;
                    AddTaskPage(dropdownvalue2: dropdownvalue2);
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
