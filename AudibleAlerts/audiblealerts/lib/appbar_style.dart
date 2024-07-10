import "package:audiblealerts/main.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:audiblealerts/styled_text.dart";

late List<Map<String, dynamic>> data;
void _retrieveData() async {
  data = await dbHelper.getData();
}

class AppBarStyles extends StatefulWidget implements PreferredSizeWidget {
  const AppBarStyles({super.key, this.titles});
  final String? titles;
  @override
  State<AppBarStyles> createState() {
    return _AppBarStylesState();
  }

  @override
  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _AppBarStylesState extends State<AppBarStyles> {
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 40,
      bottom: const TabBar(
        unselectedLabelColor: Color.fromARGB(255, 125, 0, 147),
        indicatorColor: Color.fromRGBO(255, 255, 255, 1),
        labelStyle: TextStyle(color: Colors.white, fontSize: 18),
        tabs: [
          Tab(
            text: "Today",
          ),
          Tab(
            text: "Upcoming",
          ),
          Tab(text: 'Suggested Tasks'),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 189, 85, 253),
      title: const Padding(
          padding: EdgeInsets.only(
            left: 10,
            top: 13,
          ),
          child: StyledText()),
      iconTheme: const IconThemeData(color: Colors.white),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              _retrieveData();
              setState(() {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              });
            },
            icon: const Icon(Icons.replay_rounded))
      ],
    );
  }
}
