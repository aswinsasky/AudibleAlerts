import 'dart:ui';
import "package:audiblealerts/elevated_radius.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class InputField extends StatefulWidget {
  const InputField({super.key});
  @override
  State<InputField> createState() {
    return _InputFieldState();
  }
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          width: 400,
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(1))),
              labelText: "Add Task",
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                  width: 1.0, color: Color.fromARGB(255, 40, 40, 40)),
              bottom: BorderSide(width: 1.0),
            ),
          ),
          height: 65,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                alignment: Alignment.centerLeft,
                shape: ElavatedRadius.elevatedRadius(1)),
            onPressed: () {
              showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100));
            },
            child: const Text(
              "Select Date",
              style: TextStyle(color: Colors.black),
            ),
          ),
        )
      ],
    );
  }
}
