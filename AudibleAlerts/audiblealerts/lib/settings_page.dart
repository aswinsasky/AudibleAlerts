import 'package:flutter/material.dart';
import "package:audiblealerts/appbar_style.dart";

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarStyles("Add Task"),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back_ios_new_outlined),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: const TextField(
        decoration: InputDecoration(labelText: "Add Task"),
      ),
    );
  }
}
