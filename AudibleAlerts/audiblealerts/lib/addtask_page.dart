import 'package:audiblealerts/input_fields.dart';
import 'package:flutter/material.dart';
import "package:audiblealerts/appbar_style.dart";

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarStyles("Add Task"),
      backgroundColor: Colors.white,
      body: const InputField(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () {},
        child: const Icon(Icons.check_outlined),
      ),
    );
  }
}
