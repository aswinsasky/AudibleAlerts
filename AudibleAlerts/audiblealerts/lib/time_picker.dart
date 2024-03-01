import "package:flutter/material.dart";

class TimePickerButton extends StatelessWidget {
  const TimePickerButton(this.iconcolor, {super.key});
  final Color iconcolor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showTimePicker(context: context, initialTime: TimeOfDay.now());
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
      ),
      child: Icon(
        Icons.access_alarm,
        color: iconcolor,
      ),
    );
  }
}
