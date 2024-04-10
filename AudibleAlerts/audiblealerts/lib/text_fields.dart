import "package:audiblealerts/addtask_page.dart";

import "package:flutter/material.dart";

String? textfieldValue;

class TextFieldStyle extends StatefulWidget {
  const TextFieldStyle({super.key});
  @override
  State<TextFieldStyle> createState() {
    return _TextFieldStyleState();
  }
}

class _TextFieldStyleState extends State<TextFieldStyle> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(context) {
    return TextField(
      controller: _controller,
      onChanged: (value) => _controller,
      onSubmitted: (value) {
        setState(() {
          textfieldValue = _controller.text;
          AddTaskPage(textfieldValue: textfieldValue);
        });
      },
      style: const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
      decoration: const InputDecoration(
        border: UnderlineInputBorder(borderSide: BorderSide.none),
        labelText: " Add Task Title",
        labelStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
      ),
    );
  }
}
