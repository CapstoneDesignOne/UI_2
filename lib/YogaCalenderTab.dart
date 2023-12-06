import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cabston/notification.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

int today() {
  DateTime now = DateTime.now();
  int dayOfWeek = now.weekday;
  return dayOfWeek;
}

class YogaCalenderTab extends StatefulWidget {
  const YogaCalenderTab({Key? key}) : super(key: key);

  @override
  State<YogaCalenderTab> createState() => _YogaCalenderTabState();
}

class _YogaCalenderTabState extends State<YogaCalenderTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final NotificationService notificationService = NotificationService();

  List<bool> selectedDays = [false, false, false, false, false, false, false];
  bool isNotificationEnabled = false;
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones(); // tz 패키지 초기화
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin:EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              height: 50,
              width: 100,
              child: Text(
                '요일 선택',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 100,
              width: 600,
              color: Colors.white,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(7, (index) {
                  return Container(
                    alignment: Alignment.center,
                    width: 40,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedDays[index] = !selectedDays[index];
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: selectedDays[index] ? Colors.blue : Colors.grey,
                        //minimumSize: Size(20, 20), // 최소 크기 지정
                      ),
                      child: Text(getDayName(index)),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              height: 50,
              width: 100,
              color:Colors.white,
              child: Text(
                '시간 설정',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );

                if (pickedTime != null && pickedTime != selectedTime) {
                  setState(() {
                    selectedTime = pickedTime;
                    isNotificationEnabled=true;
                    for (int i = 0; i < 7; i++) {
                      if (selectedDays[i] && ((today() - 1) == i)) {
                        notificationService.scheduleNotification(selectedTime.hour , selectedTime.minute);
                      }
                    }
                  });
                }
              },
                child: Text(
                  '${selectedTime?.hour}:${selectedTime?.minute}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ),
            Container(
              child: Text(
                '${selectedTime?.hour}:${selectedTime?.minute}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              //알림 설정 버튼
              onPressed: () {
                setState(() {
                  isNotificationEnabled = !isNotificationEnabled;
                });
                if (isNotificationEnabled) {
                  notificationService.scheduleNotification(selectedTime.hour , selectedTime.minute-1);
                } else {
                  notificationService.cancelAllNotifications();
                  print("알림 끄기");
                }
              },
              style: ElevatedButton.styleFrom(
                primary: isNotificationEnabled ? Colors.blue : Colors.grey,
              ),
              child: Text(
                isNotificationEnabled ? '켜기 ' : '끄기',
                style: TextStyle(
                  color: Colors.white, // 텍스트 색상을 흰색으로 설정
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getDayName(int dayIndex) {
    List<String> days = ['월', '화', '수', '목', '금', '토', '일'];
    return days[dayIndex];
  }
}
