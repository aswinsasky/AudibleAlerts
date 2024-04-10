import "package:audiblealerts/addtask_page.dart";
import "package:flutter/material.dart";
import "package:audiblealerts/appbar_style.dart";
import "package:audiblealerts/model/ListDate.dart";

void main() async {
  runApp(
    const AudibleAlerts(),
  );
}

ThemeMode? selectedTheme;

class AudibleAlerts extends StatefulWidget {
  const AudibleAlerts({super.key, selectedTheme});

  @override
  State<AudibleAlerts> createState() {
    return _AudibleAlertsState();
  }
}

class _AudibleAlertsState extends State<AudibleAlerts> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  final dbHelper = DatabaseHelper();
  final DateTime? selectedDate;
  final String? textfieldValue, dropdownvalue, dropdownvalue2, data;
  MyHomePage(
      {super.key,
      this.selectedDate,
      this.textfieldValue,
      this.dropdownvalue,
      this.dropdownvalue2,
      this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarStyles("AudibleAlerts"),
      body: Center(
          child: Column(
        children: [
          TextButton(
            child: Text(
              textfieldValue.toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            onPressed: () {},
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const AddTaskPage(),
              ));
        },
      ),
    );
  }
}
