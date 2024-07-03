import "dart:async";

import "package:audiblealerts/addtask_page.dart";

import "package:flutter/material.dart";
import "package:audiblealerts/appbar_style.dart";
import "package:audiblealerts/model/ListDate.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:permission_handler/permission_handler.dart";
import "package:android_alarm_manager_plus/android_alarm_manager_plus.dart";
import "package:flutter_tts/flutter_tts.dart";
import "package:path/path.dart";
import "package:sqflite/sqflite.dart";
import "package:flutter_ringtone_player/flutter_ringtone_player.dart";

final dbHelper = DatabaseHelper();
void callback(int id) async {
  final taskName = await dbHelper.getTaskName(id);
  print('Alarm triggered for task: $taskName at ${DateTime.now()}');
  FlutterTts flutterTts = FlutterTts();
  FlutterRingtonePlayer.playAlarm(volume: 0.5);
  for (int i = 0; i < 3; i++) {
    await Future.delayed(
      const Duration(seconds: 5),
    );
    await flutterTts.speak(taskName.toString());
  }
  FlutterRingtonePlayer.stop();
  dbHelper.deleteData(id);
}

void scheduleAlarm(int id, DateTime alarmTime, String taskName) async {
  print("Attempting to schedule alarm for: $taskName at $alarmTime");
  if (alarmTime.isBefore(DateTime.now())) {
    print("Alarm time is in the past. Alarm not scheduled.");
    return;
  }

  await AndroidAlarmManager.oneShotAt(
    alarmTime,
    id,
    callback,
    exact: true,
    wakeup: true,
    allowWhileIdle: true,
    rescheduleOnReboot: true,
  );
  print('Alarm scheduled for $taskName at $alarmTime');
}

Future<List<Map<String, dynamic>>> fetchAlarms(Database db) async {
  return await db.query('TaskTable');
}

Future<void> fetchAndScheduleAlarms() async {
  final db = DatabaseHelper();
  final alarms = await db.fetchAlarms();
  final now = DateTime.now();

  for (var alarm in alarms) {
    final int id = alarm['id'] as int;
    final taskName = alarm['stringValue'] as String;
    final dateTimeString = alarm['dateTimeValue'] as String?;
    if (dateTimeString == null) {
      print("Skipping");
      continue;
    }

    final dateTime = DateTime.tryParse(dateTimeString);
    if (dateTime == null) {
      continue;
    }

    if (dateTime.isAfter(now)) {
      scheduleAlarm(id, dateTime, taskName);
    } else {
      await db.deleteData(id);
      print('Deleted past alarm: $taskName scheduled at $dateTime');
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await fetchAndScheduleAlarms();

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
    AudibleAlerts(flutterLocalNotificationsPlugin),
  );
}

Future<List<Map<String, dynamic>>> _retrieveData() async {
  return await dbHelper.getData();
}

class AudibleAlerts extends StatelessWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  AudibleAlerts(this.flutterLocalNotificationsPlugin, {super.key}) {
    scheduleNotification(flutterLocalNotificationsPlugin);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(length: 2, child: MyHomePage()));
  }
}

class MyHomePage extends StatefulWidget {
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
  void initState() {
    super.initState();
    fetchAndScheduleAlarms();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: const AppBarStyles("AudibleAlerts"),
          body: FutureBuilder<List<Map<String, dynamic>>>(
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
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('Press + to add Tasks'),
                );
              }
              List<Map<String, dynamic>> data = snapshot.data!;
              List<Map<String, dynamic>> todayTasks = [];
              List<Map<String, dynamic>> upcomingTasks = [];
              DateTime now = DateTime.now();
              DateTime today =
                  DateTime(now.year, now.month, now.day, 23, 59, 59);
              DateTime upcoming = today.add(const Duration(seconds: 1));
              for (var task in data) {
                DateTime taskDueDate = DateTime.parse(task['dateTimeValue']);
                if (taskDueDate.isBefore(upcoming)) {
                  todayTasks.add(task);
                } else {
                  upcomingTasks.add(task);
                }
              }
              return TabBarView(
                children: [
                  _buildTabContent(context, todayTasks),
                  _buildTabContent(context, upcomingTasks),
                ],
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => AddTaskPage(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(
      BuildContext conext, List<Map<String, dynamic>> tasks) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: tasks.map(
        (task) {
          return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: const ButtonStyle(
                alignment: Alignment.centerLeft,
                fixedSize: MaterialStatePropertyAll(Size.fromHeight(50)),
                padding: MaterialStatePropertyAll(EdgeInsets.zero),
                backgroundColor: MaterialStatePropertyAll(Colors.white),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(1),
                    ),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    task['stringValue'].toString().toUpperCase(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const Icon(Icons.delete_outline_rounded)
                ],
              ),
              onPressed: () {
                setState(() {
                  deleteData(tasks.indexOf(task));
                });
              },
            ),
          );
        },
      ).toList(),
    ));
  }

  void resetAll() async {
    return await dbHelper.resetID();
  }
}

Future<void> deleteData(int stringVal) async {
  print('$dbHelper.stringValue');
  return await dbHelper.deleteData(stringVal);
}

void deleteAll() {
  return dbHelper.deleteAll();
}

Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('channel id', 'channel name',
          channelDescription: 'channel_name',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher');
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'audible Alerts', 'Alarm', platformChannelSpecifics);
}

void speak(String text) async {
  FlutterTts flutterTts = FlutterTts();
  await flutterTts.speak(text);
}

Future<Database> initializeDb() async {
  String path = join(await getDatabasesPath(),
      'audiblealerts.db'); // Adjust this to your database name
  return openDatabase(
    path,
    version: 1,
  );
}

void scheduleNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
  final DateTime now = DateTime.now();
  DateTime scheduleTime = DateTime(now.year, now.month, now.day, 13, 38);
  if (scheduleTime.isAfter(now)) {
    final Duration delay = scheduleTime.difference(now);
    Timer(delay, () {
      showNotification(flutterLocalNotificationsPlugin);
    });
  } else {
    final DateTime tomorrowScheduledTime =
        scheduleTime.add(const Duration(days: 1));
    final Duration delay = tomorrowScheduledTime.difference(now);

    Timer(delay, () {
      showNotification(flutterLocalNotificationsPlugin);
    });
  }
}
