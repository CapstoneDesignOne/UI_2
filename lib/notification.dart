import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  // 싱글톤 패턴을 사용하기 위한 private static 변수
  static final NotificationService _instance = NotificationService._();
  // NotificationService 인스턴스 반환
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _instance;
  }
  // private 생성자
  NotificationService._();
  // 로컬 푸시 알림을 사용하기 위한 플러그인 인스턴스 생성
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  // 초기화 작업을 위한 메서드 정의
  Future<void> init() async {
    // 알림을 표시할 때 사용할 로고를 지정
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    // 안드로이드 플랫폼에서 사용할 초기화 설정
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    // 로컬 푸시 알림을 초기화
// 로컬 푸시 알림을 초기화
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);


  }
  // 푸시 알림 생성
  Future<void> showNotification(int targetNumber) async {
    // 푸시 알림의 ID
    const int notificationId = 0;
    // 알림 채널 설정값 구성
    final AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'counter_channel', // 알림 채널 ID
      '요가 알림', // 알림 채널 이름
      channelDescription:
      'This channel is used for yoga-time notifications',
      // 알림 채널 설명
      importance: Importance.high, // 알림 중요도
    );
    // 알림 상세 정보 설정
    final NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    // 알림 보이기
    await flutterLocalNotificationsPlugin.show(
      notificationId, // 알림 ID
      '운동 시작!', // 알림 제목
      '오늘 요가도 힘내봐요!', // 알림 메시지
      notificationDetails, // 알림 상세 정보
    );
  }
  // 푸시 알림 권한 요청
  Future<PermissionStatus> requestNotificationPermissions() async {
    final status = await Permission.notification.request();
    return status;
  }
  //로컬 알림 예약
  Future<void> scheduleNotification(int hour, int minute) async {
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final DateTime scheduledDate = DateTime(
        now.year,
        now.month,
        now.day,
        hour,
        minute
    );
    print("---현재 시간과 예약된 시간이 일치하는지 확인-");

    print(tz.TZDateTime.from(
      tz.TZDateTime.now(tz.local),
      tz.local,
    ));
    print(scheduledDate);
    print("---");
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription:
      'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      //channelShowBadge: true,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await FlutterLocalNotificationsPlugin().zonedSchedule(
      0, // 알림 ID
      'Yobis',
      '오늘은 요가 하는 날이에요!',
      tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails,
      payload: 'your_payload',
      //androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
  // 알림 취소
  Future<void> cancelNotification(int day) async {
    // 푸시 알림의 ID
    int notificationId = day * 10;

    // 알림 취소
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }
  // 모든 알림 취소
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }


}