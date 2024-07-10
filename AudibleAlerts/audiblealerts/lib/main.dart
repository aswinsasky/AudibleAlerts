import "dart:async";
import "dart:convert";

import "package:audiblealerts/addtask_page.dart";
import "package:audiblealerts/input_fields.dart";
import "package:flutter/cupertino.dart";

import "package:flutter/material.dart";
import "package:audiblealerts/appbar_style.dart";
import "package:audiblealerts/model/ListDate.dart";
import "package:flutter/widgets.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:permission_handler/permission_handler.dart";
import "package:android_alarm_manager_plus/android_alarm_manager_plus.dart";
import "package:flutter_tts/flutter_tts.dart";
import "package:path/path.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:sqflite/sqflite.dart";
import "package:flutter_ringtone_player/flutter_ringtone_player.dart";

final dbHelper = DatabaseHelper();
late List<Map<String, dynamic>> number;
final speakTasks = dbHelper.fetchAlarms();

class Task {
  final String title;
  final String description;
  bool isCompleted;
  Task(
      {required this.title,
      required this.description,
      this.isCompleted = false});
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  static Task fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
    );
  }
}

List<Task> suggestedTasks = [
  Task(
    title: 'Hydration Habit',
    description: 'Drink 8 glasses of water today.',
  ),
  Task(
    title: 'Morning Routine',
    description:
        'Spend 10 minutes stretching or doing light exercises after waking up.',
  ),
  Task(
    title: 'GoodBye Routine',
    description: 'Say GoodBye to someone you love with a kiss',
  ),
  Task(
    title: 'Gratitude Journal',
    description: "Write down 3 things you're grateful for today.",
  ),
  Task(
    title: 'Connect with Nature',
    description: 'Plant a tree and water it',
  ),
  Task(
    title: 'Random Act of Kindness',
    description: 'Do something kind for someone else today.',
  ),
  Task(
    title: 'Reflect and Plan',
    description: 'Reflect on everything you did today',
  ),
  Task(
    title: 'Maintain Hygeine',
    description: 'Clean your room and yourself',
  ),
  Task(
    title: 'Learn Something New',
    description: 'Spend 20 minutes learning something new today.',
  ),
  Task(
    title: 'Social Connection',
    description:
        "Call or meet a friend or family member you haven't talked to in a while.",
  ),
  Task(
    title: 'Maintain Connection',
    description: 'Greet Everyone you meet today',
  ),
  Task(
    title: 'Build  Healthy Relation',
    description: 'Compliment your family and peers',
  ),
  Task(
    title: 'Limit Social Media',
    description: 'Limit social media use to 30 minutes today.',
  ),
  Task(
    title: 'Helping Mentality',
    description: 'Help people who require help if you can',
  ),
  Task(
    title: 'Reading mentality',
    description: 'Start Reading a book',
  ),
  Task(
    title: 'Volunteering',
    description: 'Spend time volunteering or helping out in your community',
  ),
  Task(
    title: 'Speak Up',
    description: 'Try Talking to someone new',
  ),
  Task(
    title: 'Digital-Free Evening',
    description: 'Spend the evening without using any digital devices today.',
  ),
  Task(
    title: 'Personal Development',
    description: 'Try to think from the perspective of others',
  ),
  Task(
    title: 'Celebrate and Share',
    description:
        'Celebrate even the smallest achievements with your loved ones',
  ),
];
void _getData() async {
  number = await dbHelper.getData();
}

void cancelNotification(int id) async {
  await AndroidAlarmManager.cancel(id);
  print('The Notification at $id is deleted');
}

void callback(int id) async {
  _getData();
  showNotification(FlutterLocalNotificationsPlugin());
  final dropDownValue = await dbHelper.getTaskName(id, 'dropdownvalue1');
  final dropDownValue2 = await dbHelper.getTaskName(id, 'dropdownvalue2');
  final taskName = await dbHelper.getTaskName(id, 'stringValue');
  String nextdateTime = dbHelper.getTaskName(id, 'dateTimeValue').toString();
  if (nextdateTime == null) {
    nextdateTime = '$DateTime.now()';
  }
  DateTime? nextdateTime2 = DateTime.tryParse(nextdateTime);
  if (nextdateTime2 == null) {
    nextdateTime2 = DateTime.now();
  }
  int nextdateTime4 = nextdateTime2.hour;
  int nextdateTime5 = nextdateTime2.minute;
  DateTime nextdateTime3 = DateTime(nextdateTime2.year, nextdateTime2.month,
      nextdateTime2.day + 1, nextdateTime2.hour, nextdateTime2.minute);
  DateTime nextdateTime6 = DateTime(nextdateTime2.year, nextdateTime2.month,
      nextdateTime2.day, nextdateTime2.hour, nextdateTime5 + 2);
  print('Alarm triggered for task: $taskName at ${DateTime.now()}');

  FlutterTts flutterTts = FlutterTts();
  flutterTts.setVoice({'name': 'Karen'});
  flutterTts.setPitch(1.0);
  flutterTts.setSpeechRate(0.4);
  FlutterRingtonePlayer.playAlarm(volume: 0.5);
  for (int i = 0; i < 2; i++) {
    await Future.delayed(
      const Duration(seconds: 5),
    );
    await flutterTts.speak(
        'It is ,$nextdateTime4 $nextdateTime5,Time to ,${taskName.toString()}');
  }
  FlutterRingtonePlayer.stop();
  print('The length is ${number.length}');
  if (dropDownValue2.toString() == '2 minutes' ||
      dropDownValue2.toString() == '5 minutes') {
    if (dropDownValue2.toString() == '2 minutes') {
      dbHelper.insertData(
          number.length,
          taskName.toString(),
          nextdateTime2.add(const Duration(minutes: 2)).toString(),
          dbHelper.getTaskName(id, dropdownvalue).toString(),
          dropDownValue.toString());
    } else {
      dbHelper.insertData(
          number.length,
          taskName.toString(),
          nextdateTime2.add(const Duration(minutes: 5)).toString(),
          dbHelper.getTaskName(id, dropdownvalue).toString(),
          dropDownValue.toString());
    }
  }
  if (dropDownValue.toString() == 'Daily' &&
      dropDownValue2 == '2 minutes' &&
      dropDownValue2 == '5 minutes') {
    dbHelper.insertData(
        number.length + 1,
        taskName.toString(),
        nextdateTime3.toString(),
        dropDownValue2.toString(),
        dropDownValue.toString());
  }
  deleteData(id);
  MyHomePage();
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

Future<void> fetchTaskList() async {
  DateTime now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day, 23, 59, 59);
  final db = DatabaseHelper();
  final taskToday = await db.fetchAlarms();
  FlutterTts flutterTts = FlutterTts();
  flutterTts.setSpeechRate(0.4);
  flutterTts.speak("Welcome, Today's,   Tasks are: ");
  for (var tasksToday in taskToday) {
    final dateTime = tasksToday['dateTimeValue'] as String?;
    if (dateTime == null) {
      continue;
    }
    final dateTime2 = DateTime.tryParse(dateTime);
    if (dateTime2 == null) {
      continue;
    }
    if (dateTime2.isBefore(today)) {
      await Future.delayed(const Duration(seconds: 4));
      await flutterTts.speak('Task, ${tasksToday['stringValue']}');
      Future.delayed(const Duration(seconds: 1));
    }
  }
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
      MyHomePage();
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
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (payload) async {
    FlutterRingtonePlayer.stop();
  });
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
        home: DefaultTabController(length: 3, child: MyHomePage()));
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
    _getData();
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
    _loadTasks();
    fetchAndScheduleAlarms();
  }

  void reloadPage() {
    setState(() {
      MyHomePage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: const AppBarStyles(),
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
                    todayTasks.isEmpty
                        ? const Center(
                            child: Text('Press + to add tasks'),
                          )
                        : _buildTabContent(context, todayTasks),
                    upcomingTasks.isEmpty
                        ? const Center(child: Text('Press + to add tasks'))
                        : _buildTabContent(context, upcomingTasks),
                    _buildNewTabContent(context),
                  ],
                );
              },
            ),
            floatingActionButton: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    heroTag: 'fab1',
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      heroTag: 'fab2',
                      onPressed: () async {
                        Future.delayed(const Duration(seconds: 2));
                        await fetchTaskList();
                      },
                      child: const Icon(Icons.hearing),
                    ),
                  ),
                )
              ],
            )),
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
                  cancelNotification(tasks.indexOf(task));
                  deleteData(tasks.indexOf(task));
                });
              },
            ),
          );
        },
      ).toList(),
    ));
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? taskJsonList = prefs.getStringList('tasks');
    if (taskJsonList != null) {
      setState(() {
        suggestedTasks = taskJsonList
            .map((taskJson) =>
                Task.fromJson(Map<String, dynamic>.from(json.decode(taskJson))))
            .toList();
      });
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> taskJsonList =
        suggestedTasks.map((task) => json.encode(task.toJson())).toList();
    prefs.setStringList('tasks', taskJsonList);
  }

  double get _CompletionProgress {
    int completedTasks =
        suggestedTasks.where((task) => task.isCompleted).length;
    return completedTasks / suggestedTasks.length;
  }

  Widget _buildNewTabContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(left: 10, top: 20)),
          const Text(
            '20 Tasks Challenge',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: LinearProgressIndicator(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              minHeight: 20.0,
              value: _CompletionProgress,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
          const SizedBox(
            child: Text('Progress Indicator'),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: suggestedTasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  tileColor: Colors.white,
                  title: Text(
                    suggestedTasks[index].title,
                    style: TextStyle(
                      decoration: suggestedTasks[index].isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text(suggestedTasks[index].description),
                  trailing: Icon(suggestedTasks[index].isCompleted
                      ? Icons.check_box_sharp
                      : Icons.check_box_outline_blank_sharp),
                  onTap: () {
                    setState(() {
                      suggestedTasks[index].isCompleted =
                          !suggestedTasks[index].isCompleted;
                      suggestedTasks.add(Task(
                          title: suggestedTasks[index].title,
                          description: suggestedTasks[index].description,
                          isCompleted: suggestedTasks[index].isCompleted));
                      suggestedTasks.removeAt(index);
                      int completedTasks = suggestedTasks
                          .where((task) => task.isCompleted)
                          .length;
                      if (completedTasks == 10) {
                        FlutterTts flutterTts2 = FlutterTts();
                        flutterTts2.setSpeechRate(0.4);
                        flutterTts2.speak(
                            "Congrats,You Have Completed 10 Daily Tasks. Only 10 more to go, to complete this challenge");
                      }
                      _saveTasks();
                    });
                  },
                );
              },
            ),
          )
        ],
      ),
    );
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
      AndroidNotificationDetails(
    'channel id',
    'channel name',
    channelDescription: 'channel_name',
    importance: Importance.high,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher',
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'audible Alerts', 'Alarm is Ringing', platformChannelSpecifics,
      payload: 'notification_payload');
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
