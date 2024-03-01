import "package:flutter/material.dart";
import "package:audiblealerts/elevated_radius.dart";

class DatePickerButton extends StatelessWidget {
  const DatePickerButton({super.key});
  @override
  Widget build(context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromWidth(300),
          maximumSize: const Size.fromWidth(330),
          side: const BorderSide(
              style: BorderStyle.none,
              color: Color.fromRGBO(255, 255, 255, 1),
              width: 0),
          padding: const EdgeInsets.only(left: 6),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          alignment: Alignment.centerLeft,
          shape: ElavatedRadius.elevatedRadius(0)),
      onPressed: () {
        showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime(2100));
      },
      label: const Text(
        "Select Date",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
      ),
      icon: const Icon(
        Icons.calendar_month_outlined,
        color: Colors.black,
      ),
    );
  }
}
