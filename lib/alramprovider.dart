import 'package:flutter/material.dart';
import 'notification.dart';

class AlramProvider with ChangeNotifier {
  List<bool> selectedDays = List.generate(7, (index) => false);
  TimeOfDay selectedTime = TimeOfDay(hour: 12, minute: 0); // Default alarm time
  bool _alarmState = false; // Internal variable to store notification status

  List<bool> get getSelectedDays => selectedDays;
  TimeOfDay get getSelectedTime => selectedTime;
  bool get alarmState => _alarmState;

  void updateSelectedDay(int index, bool newValue) {
    selectedDays[index] = newValue;
    notifyListeners();

    if (newValue) {
      _scheduleNotificationForDay(index);
    }
  }

  void _scheduleNotificationForDay(int dayIndex) {
    DateTime now = DateTime.now();
    DateTime scheduledDate = DateTime(
      now.year,
      now.month,
      now.day + ((dayIndex + 7 - now.weekday) % 7),
      selectedTime.hour,
      selectedTime.minute,
    );

    NotificationService().scheduleNotification;
  }

  // Method to update the selected alarm time
  void updateSelectedTime(TimeOfDay? newTime) {
    if (newTime != null) {
      selectedTime = newTime;
      notifyListeners();
    }
  }

  // Method to update the notification status
  void updateAlarmState(bool newState) {
    _alarmState = newState;
    notifyListeners();
  }
}
