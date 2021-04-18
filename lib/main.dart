import 'package:clock_app/enums.dart';
import 'package:clock_app/homepage.dart';
import 'package:clock_app/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //android initialization setting
  var androidSettings =
      AndroidInitializationSettings('flutter_icon');

  //ios initialization setting
  var iosSettings = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});

  //initializing both android and ios settings
  var initializingSettings =
      InitializationSettings(androidSettings, iosSettings);

  //calling initialize method on flutterLocalNotificationsPlugin
  await flutterLocalNotificationsPlugin.initialize(initializingSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('Notification payload' + payload);
    }
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      //creating object
      home: ChangeNotifierProvider<MenuType>(
          create: (context) => MenuType(MenuList.clock), child: HomeScreen()),
    );
  }
}
