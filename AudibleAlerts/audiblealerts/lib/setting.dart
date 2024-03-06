import "package:audiblealerts/main.dart";
import "package:flutter/material.dart";
import "package:audiblealerts/appbar_style.dart";

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});
  @override
  State<SettingPage> createState() {
    return SettingPageState();
  }
}

class SettingPageState extends State<SettingPage> {
  bool selected =false;

  ThemeMode themeMode = ThemeMode.system;
  void _toggleTheme(ThemeMode selthemeMode) {
    setState(() {
      themeMode = selthemeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: const AppBarStyles("settings"),
        backgroundColor: Colors.white,
        body: Row(
          children: [
            const Text(
              "Dark Mode",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
            Switch(
                value: selected,
                activeColor: const Color.fromARGB(255, 223, 64, 244),
                onChanged: (value) {
                  setState(() {
                    selected=value;
                    selected
                        ? _toggleTheme(ThemeMode.dark)
                        : _toggleTheme(ThemeMode.light);
                        AudibleAlerts(selectedTheme:themeMode);
                  });
                })
          ],
        ));
  }
}
