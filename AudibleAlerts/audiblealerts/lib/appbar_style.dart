import "package:flutter/material.dart";
import "package:audiblealerts/styled_text.dart";

class AppBarStyles extends StatelessWidget implements PreferredSizeWidget {
  const AppBarStyles(this.titles, {super.key});
  final String titles;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: StyledText(titles),
      iconTheme: const IconThemeData(color: Colors.white),
      actions: const <Widget>[
        Icon(
          Icons.more_vert,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
