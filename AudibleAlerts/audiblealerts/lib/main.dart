import "package:audiblealerts/settings_page.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:audiblealerts/appbar_style.dart";
import "package:flutter/widgets.dart";

void main() {
  runApp(
    const AudibleAlerts(),
  );
}

class AudibleAlerts extends StatelessWidget {
  const AudibleAlerts({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarStyles("AudibleAlerts"),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const SettingsPage(),
              ));
        },
      ),
    );
  }
}
