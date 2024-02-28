import 'package:audiblealerts/input_fields.dart';
import 'package:flutter/material.dart';
import "package:audiblealerts/appbar_style.dart";

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarStyles("Add Task"),
      backgroundColor: Colors.white,
      body: InputField(),
    );
  }
}
