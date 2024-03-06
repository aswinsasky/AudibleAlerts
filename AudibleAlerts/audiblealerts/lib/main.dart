import "package:audiblealerts/addtask_page.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:audiblealerts/appbar_style.dart";
import "package:flutter/widgets.dart";

void main() {
  runApp(
     const AudibleAlerts(),
  );
}
 ThemeMode? selectedTheme;
class AudibleAlerts extends StatefulWidget {
  const AudibleAlerts({super.key,selectedTheme});
  
@override
State<AudibleAlerts>createState(){
  return  _AudibleAlertsState();
}
}
 
  class _AudibleAlertsState extends State<AudibleAlerts>{

    @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.light(),themeMode:selectedTheme,home: const MyHomePage());
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
                builder: (context) => const AddTaskPage(),
              ));
        },
      ),
    );
  }

  }

