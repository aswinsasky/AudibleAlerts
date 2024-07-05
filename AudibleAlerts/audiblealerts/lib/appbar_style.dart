import "package:audiblealerts/main.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:audiblealerts/styled_text.dart";

class AppBarStyles extends StatelessWidget implements PreferredSizeWidget {
  const AppBarStyles(this.titles, {super.key});
  final String titles;
  @override
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
      title: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            top: 13,
          ),
          child: StyledText(
            titles,
          )),
      iconTheme: const IconThemeData(color: Colors.white),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              speak('HI All');
            },
            icon: const Icon(Icons.settings_sharp))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
