import "package:flutter/material.dart";

class TimePickerButton extends StatefulWidget {
  const TimePickerButton({super.key});
  @override
  State<TimePickerButton> createState() {
    return _TimePickerButtonState();
  }
}

dynamic _selectedTime;

class _TimePickerButtonState extends State<TimePickerButton> {
  @override
  Widget build(context) {
    return ElevatedButton(
      onPressed: () async {
        final dynamic timevalue = await showTimePicker(
            context: context, initialTime: TimeOfDay.now());
        if (timevalue != null && timevalue != _selectedTime) {
          setState(() {
            _selectedTime = timevalue;
          });
        }
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
      child: const Icon(
        Icons.access_alarm,
        color: Color.fromARGB(255, 143, 7, 141),
      ),
    );
  }
}
