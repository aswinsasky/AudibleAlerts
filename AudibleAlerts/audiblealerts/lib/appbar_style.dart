import "package:audiblealerts/main.dart";
import "package:flutter/material.dart";
import "package:audiblealerts/styled_text.dart";

class AppBarStyles extends StatelessWidget implements PreferredSizeWidget {
  const AppBarStyles(this.titles, {super.key});
  final String titles;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 189, 85, 253),
      title: StyledText(titles),
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
