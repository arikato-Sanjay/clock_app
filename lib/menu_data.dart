import 'dart:ui';

import 'package:clock_app/enums.dart';
import 'alarm_info.dart';
import 'menu_model.dart';

//will reduce the code, listing and map can be used
List<MenuType> list = [
  MenuType(MenuList.clock,
      title: 'Clock', imgSource: 'assets/images/clock.png'),
  MenuType(MenuList.alarm,
      title: 'Alarm', imgSource: 'assets/images/alarm.png'),
  MenuType(MenuList.timer,
      title: 'Timer', imgSource: 'assets/images/timer.png'),
  MenuType(MenuList.stopwatch,
      title: 'Stopwatch', imgSource: 'assets/images/stopwatch.png'),
];

List<AlarmInfo> alarms = [
  AlarmInfo(
      alarmDateTime: DateTime.now().add(Duration(hours: 1)),
      description: 'Office',
      gradientIndex: 0),
  AlarmInfo(
      alarmDateTime: DateTime.now().add(Duration(hours: 2)),
      description: 'Playing',
      gradientIndex: 1)
];

class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);

  static List<Color> first = [Color(0xFFEE9AE5), Color(0xFF5961F9)];
  static List<Color> second = [Color(0xFFBC78EC), Color(0xFF3B2667)];
  static List<Color> third = [Color(0xFFFDD819), Color(0xFFE80505)];
  static List<Color> forth = [Color(0xFFFFF886), Color(0xFFF072B6)];
  static List<Color> fifth = [Color(0xFF3CD500), Color(0xFFFFF720)];
  static List<Color> sixth = [Color(0xFF513162), Color(0xFFFF7AF5)];
}

class GradientTemplate {
  static List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.first),
    GradientColors(GradientColors.second),
    GradientColors(GradientColors.third),
    GradientColors(GradientColors.forth),
    GradientColors(GradientColors.fifth),
    GradientColors(GradientColors.sixth),
  ];
}
