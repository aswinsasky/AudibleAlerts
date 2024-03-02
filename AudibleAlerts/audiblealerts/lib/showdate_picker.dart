import "package:flutter/material.dart";
import "package:audiblealerts/elevated_radius.dart";

class DatePickerButton extends StatefulWidget {
  const DatePickerButton({super.key});
  @override
  State<DatePickerButton> createState() {
    return _DatePickerButtonState();
  }
}

class _DatePickerButtonState extends State<DatePickerButton> {
  DateTime? _selectedDate;
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
      onPressed: () async {
        final DateTime? picked = await showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime(2100));
        if (picked != null && picked != _selectedDate) {
          final timePicked = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          setState(
            () {
              if (timePicked != null) {
                _selectedDate = DateTime(
                  picked.year,
                  picked.month,
                  picked.day,
                  timePicked.hour,
                  timePicked.minute,
                );
              }
            },
          );
        }
      },
      label: Text(
        _selectedDate == null ? "Select Date" : "Date:$_selectedDate",
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
      ),
      icon: const Icon(
        Icons.calendar_month_outlined,
        color: Colors.black,
      ),
    );
  }
}
