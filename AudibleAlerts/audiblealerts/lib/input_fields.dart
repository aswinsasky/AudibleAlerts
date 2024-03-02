import 'package:audiblealerts/text_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:audiblealerts/time_picker.dart";
import "package:audiblealerts/showdate_picker.dart";
import 'package:flutter/widgets.dart';

const List<String> list = <String>[
  "5 minutes",
  "10 minutes",
  "15 minutes",
  "30 minutes",
  "45 minutes",
  "1 hour",
  "No Snooze"
];
const List<String> list2 = <String>[
  "Daily",
  "Weekly",
  "Monthly",
  "Do not Repeat",
];
String dropdownvalue = list.first;
String dropdownvalue2 = list2.first;

class InputField extends StatefulWidget {
  final dynamic selectedTime;
  const InputField({super.key, this.selectedTime});

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
