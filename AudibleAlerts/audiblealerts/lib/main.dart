import "package:audiblealerts/addtask_page.dart";

import "package:flutter/material.dart";
import "package:audiblealerts/appbar_style.dart";
import "package:audiblealerts/model/ListDate.dart";
import "package:permission_handler/permission_handler.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var notificationStatus = await Permission.notification.status;

  if (!notificationStatus.isGranted) {
    bool showRationale =
        await Permission.notification.shouldShowRequestRationale;

    if (!showRationale) {
      notificationStatus = await Permission.notification.request();
      if (notificationStatus.isGranted) {
        print('Notification is granted');
      }
    } else {
      print('Notification denied');
    }
  } else {
    print("Already granted");
  }
  runApp(
    AudibleAlerts(),
  );
}

Future<List<Map<String, dynamic>>> _retrieveData() async {
  return await dbHelper.getData();
}

class AudibleAlerts extends StatelessWidget {
  const AudibleAlerts({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  final dbHelper = DatabaseHelper();
  final DateTime? selectedDate;
  final String? textfieldValue, dropdownvalue, dropdownvalue2;

  MyHomePage(
      {super.key,
      this.selectedDate,
      this.textfieldValue,
      this.dropdownvalue,
      this.dropdownvalue2}) {
    _retrieveData();
  }
  @override
  State<MyHomePage> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarStyles("AudibleAlerts"),
        body: FutureBuilder<void>(
          future: _retrieveData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              List<Map<String, dynamic>> data =
                  snapshot.data as List<Map<String, dynamic>>;
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (data.isNotEmpty)
                        ...List.generate(
                          data.length,
                          (index) {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                  alignment: Alignment.centerLeft,
                                  fixedSize: MaterialStatePropertyAll(
                                      Size.fromHeight(50)),
                                  padding:
                                      MaterialStatePropertyAll(EdgeInsets.zero),
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white),
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(1),
                                      ),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      data[index]['stringValue']
                                          .toString()
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const Icon(Icons.delete_outline_rounded)
                                  ],
                                ),
                                onPressed: () {
                                  setState(() {
                                    _deleteData(index);
                                  });
                                },
                              ),
                            );
                          },
                        )
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => AddTaskPage(),
                        ));
                  },
                ),
              );
            }
          },
        ));
  }

  void _deleteData(int stringVal) async {
    print('$dbHelper.stringValue');
    return await dbHelper.deleteData(stringVal);
  }

  void _deleteAll() {
    return dbHelper.deleteAll();
  }

  void resetAll() async {
    return await dbHelper.resetID();
  }
}
