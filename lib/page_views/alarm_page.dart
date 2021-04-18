import 'dart:math';
import 'file:///E:/Tutorials/Projects/AndroidProjects/clock_app/lib/database_helper/alarm_database.dart';
import 'package:clock_app/alarm_info.dart';
import 'package:clock_app/main.dart';
import 'package:clock_app/menu_data.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  String _alarmTimeString;
  DateTime _alarmTime;
  AlarmDatabase _alarmDatabase = AlarmDatabase();
  Future<List<AlarmInfo>> _alarms;
  TextEditingController titleTEC = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _alarmTime = DateTime.now();
    _alarmDatabase.initializeDatabase().then((value) {
      print('=======database initialised');
    });
    loadAlarms();
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmDatabase.getAlarms();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alarm',
            style: TextStyle(
                color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: FutureBuilder<List<AlarmInfo>>(
              future: _alarms,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: snapshot.data.map<Widget>((alarm) {
                      var alarmTime =
                          DateFormat('hh:mm aa').format(alarm.alarmDateTime);
                      var gradientColor = GradientTemplate
                          .gradientTemplate[alarm.gradientIndex].colors;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: gradientColor,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                          boxShadow: [
                            BoxShadow(
                                color: gradientColor.last.withOpacity(0.5),
                                blurRadius: 6,
                                spreadRadius: 0.5,
                                offset: Offset(4, 4))
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.label,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      alarm.description,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                                Switch(
                                  value: true,
                                  onChanged: (bool value) {},
                                  activeColor: Colors.white,
                                )
                              ],
                            ),
                            Text(
                              'Mon - Fri',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  alarmTime,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                                IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Colors.white,
                                    onPressed: () {
                                      deleteAlarm(alarm.id);
                                    })
                              ],
                            )
                          ],
                        ),
                      );
                    }).followedBy([
                      DottedBorder(
                        strokeWidth: 2,
                        color: Colors.white,
                        strokeCap: StrokeCap.butt,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(20),
                        dashPattern: [5, 4],
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: FlatButton(
                            padding: EdgeInsets.all(20),
                            onPressed: () {
                              _alarmTimeString =
                                  DateFormat('HH:mm').format(DateTime.now());
                              showModalBottomSheet(
                                  useRootNavigator: true,
                                  context: context,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(24))),
                                  builder: (context) {
                                    return StatefulBuilder(
                                        builder: (context, setModalState) {
                                      return Container(
                                        padding: EdgeInsets.all(32),
                                        child: Column(
                                          children: [
                                            FlatButton(
                                              onPressed: () async {
                                                var selectedTime =
                                                    await showTimePicker(
                                                        context: context,
                                                        initialTime:
                                                            TimeOfDay.now());
                                                if (selectedTime != null) {
                                                  final now = DateTime.now();
                                                  var selectedDateTime =
                                                      DateTime(
                                                    now.year,
                                                    now.month,
                                                    now.day,
                                                    selectedTime.hour,
                                                    selectedTime.minute,
                                                  );
                                                  _alarmTime = selectedDateTime;
                                                  setModalState(() {
                                                    _alarmTimeString =
                                                        DateFormat('HH:mm')
                                                            .format(
                                                                selectedDateTime);
                                                  });
                                                }
                                              },
                                              child: Text(
                                                _alarmTimeString,
                                                style: TextStyle(fontSize: 32),
                                              ),
                                            ),
                                            Container(
                                              child: Form(
                                                key: formKey,
                                                child: TextFormField(
                                                  validator: (val){
                                                    return val.isEmpty ? 'Field Required' : null;
                                                  },
                                                  controller: titleTEC,
                                                  decoration: InputDecoration(
                                                      hintText: 'Alarm Title',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .black)),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .black))),
                                                ),
                                              ),
                                            ),
                                            ListTile(
                                              title: Text('Repeat'),
                                              trailing:
                                                  Icon(Icons.arrow_forward_ios),
                                            ),
                                            ListTile(
                                              title: Text('Sound'),
                                              trailing:
                                                  Icon(Icons.arrow_forward_ios),
                                            ),
                                            FloatingActionButton.extended(
                                              onPressed: onSaveAlarm,
                                              icon: Icon(Icons.alarm),
                                              label: Text('Save'),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                                  });
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.add_alarm_outlined,
                                  size: 40,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Add Alarm',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ]).toList(),
                  );
                }
                return Center(
                  child: Text(
                    'Loading...',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void scheduleAlarm(
      DateTime scheduledAlarmDateTme, AlarmInfo alarmInfo) async {
    var androidSpecifics = AndroidNotificationDetails(
        'alarm_notif', 'alarm_notif', 'Channel for Alarm Notification',
        icon: 'flutter_icon',
        //sound: RawResourceAndroidNotificationSound('alarms.wav'),
        largeIcon: DrawableResourceAndroidBitmap('flutter_icon'));

    var iosSpecifics = IOSNotificationDetails(
      //sound: 'alarms.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    var bothSpecifics = NotificationDetails(androidSpecifics, iosSpecifics);

    await flutterLocalNotificationsPlugin.schedule(0, 'Playing',
        alarmInfo.description, scheduledAlarmDateTme, bothSpecifics);
  }

  void onSaveAlarm() {

    if(formKey.currentState.validate()){
      DateTime scheduledAlarmDateTme;
      if (_alarmTime.isAfter(DateTime.now()))
        scheduledAlarmDateTme = _alarmTime;
      else
        scheduledAlarmDateTme = _alarmTime.add(Duration(days: 1));

      Random random = new Random();
      int colorIndex = random.nextInt(6);

      var alarmInfo = AlarmInfo(
          alarmDateTime: scheduledAlarmDateTme,
          gradientIndex: colorIndex,
          description: titleTEC.text);

      _alarmDatabase.insertAlarm(alarmInfo);
      scheduleAlarm(scheduledAlarmDateTme, alarmInfo);
      Navigator.pop(context);
      loadAlarms();
    }
  }

  void deleteAlarm(int id) {
    _alarmDatabase.delete(id);
    loadAlarms();
  }
}
