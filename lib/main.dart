import 'package:flutter/material.dart';
import 'home.dart';
import 'notification_list.dart';
import 'notification_view.dart';
import 'global.dart';
import 'notification_creat.dart';
import 'notification_add.dart';
import 'notification_formation.dart';
import 'notification_group.dart';
import 'notification_1.dart';
import 'notification_2.dart';
import 'notification_3.dart';
import 'notification_Bu.dart';

void main() {
  firebaseInit();


  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        '/notificationList':
            (BuildContext context) => NotificationListPage(),
        '/notificationView':
            (BuildContext context) => NotificationViewPage(),
        '/notificationCreate':
            (BuildContext context) => NotificationCreationPage(),
        '/notificationAdd':
            (BuildContext context) => NotificationAddPage(),
        '/notificationGroup':
            (BuildContext context) => NotificationGroupPage(),
        '/notificationFormation':
            (BuildContext context) => NotificationFormationPage(),
        '/notification1':
            (BuildContext context) => Notification1Page(),
        '/notification2':
            (BuildContext context) => Notification2Page(),
        '/notification3':
            (BuildContext context) => Notification3Page(),
        '/notificationBu':
            (BuildContext context) => NotificationBuPage(),

      },
    );
  }
}