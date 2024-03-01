import "package:flutter/material.dart";

class TextFieldStyle extends StatelessWidget {
  const TextFieldStyle({super.key});
  @override
  Widget build(context) {
    return const TextField(
      style: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        border: UnderlineInputBorder(borderSide: BorderSide.none),
        labelText: " Add Task Title",
        labelStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
      ),
    );
  }
}
