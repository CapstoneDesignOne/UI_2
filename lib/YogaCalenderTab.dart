import 'package:cabston/pose_detection/pose_detector_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cabston/notification.dart';
import 'package:permission_handler/permission_handler.dart';

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

class _YogaCalenderTabState extends State<YogaCalenderTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final NotificationService notificationService = NotificationService();

  List<bool> selectedDays = [false, false, false, false, false, false, false];
  bool isNotificationEnabled = false;
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _requestNotificationPermissions(); // 알림 권한 요청
  }

  void _requestNotificationPermissions() async {
    //알림 권한 요청
    final status =
    await NotificationService().requestNotificationPermissions();
    if (status.isDenied && context.mounted) {
      showDialog(
        // 알림 권한이 거부되었을 경우 다이얼로그 출력
        context: context,
        builder: (context) => AlertDialog(
          title: Text('알림 권한이 거부되었습니다.'),
          content: Text('알림을 받으려면 앱 설정에서 권한을 허용해야 합니다.'),
          actions: <Widget>[
            TextButton(
              child: Text('설정'), //다이얼로그 버튼의 죄측 텍스트
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings(); //설정 클릭시 권한설정 화면으로 이동
              },
            ),
            TextButton(
              child: Text('취소'), //다이얼로그 버튼의 우측 텍스트
              onPressed: () => Navigator.of(context).pop(), //다이얼로그 닫기
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixin 사용을 위한 호출
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              color: Colors.white,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  '운동할 요일을 선택해보세요!',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 25),
            Card(
              color: Colors.white,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(7, (index) {
                    return Container(
                      width: 45,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedDays[index] = !selectedDays[index];
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary:
                          selectedDays[index] ? Color(0xff00BA89) : Color(0xFFC8FCC3),
                        ),
                        child: Text(
                          getDayName(index),
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              color: Colors.white,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '시간 설정',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );

                        if (pickedTime != null &&
                            pickedTime != selectedTime) {
                          setState(() {
                            selectedTime = pickedTime;
                            isNotificationEnabled = true;
                            for (int i = 0; i < 7; i++) {
                              if (selectedDays[i] && ((today() - 1) == i)) {
                                notificationService.scheduleNotification(
                                    selectedTime.hour, selectedTime.minute);
                              }
                            }
                          });
                        }
                      },
                      child: Text(
                        '${selectedTime.hour}:${selectedTime.minute} ${selectedTime.period == DayPeriod.am ? 'AM' : 'PM'}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff00BA89),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              color: Colors.white,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '알림 설정',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Switch(
                      value: isNotificationEnabled,
                      onChanged: (value) {
                        setState(() {
                          isNotificationEnabled = value;
                        });
                        if (isNotificationEnabled) {
                          notificationService.scheduleNotification(
                              selectedTime.hour, selectedTime.minute);
                        } else {
                          notificationService.cancelAllNotifications();
                          print("알림 끄기");
                        }
                      },
                      activeColor: Color(0xff00BA89), // 스위치가 활성 상태일 때의 색상
                      inactiveThumbColor: Colors.grey, // 스위치가 비활성 상태일 때의 색상
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                    ),
                  ],
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

