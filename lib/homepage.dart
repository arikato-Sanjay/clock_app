import 'file:///E:/Tutorials/Projects/AndroidProjects/clock_app/lib/page_views/alarm_page.dart';
import 'file:///E:/Tutorials/Projects/AndroidProjects/clock_app/lib/page_views/clock_page.dart';
import 'package:clock_app/enums.dart';
import 'package:clock_app/menu_data.dart';
import 'package:clock_app/menu_model.dart';
import 'file:///E:/Tutorials/Projects/AndroidProjects/clock_app/lib/page_views/stopwatch_page.dart';
import 'file:///E:/Tutorials/Projects/AndroidProjects/clock_app/lib/page_views/timer_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [const Color(0xFF9FA4C4), const Color(0xFFB3CDD1)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Row(
          children: [
            Expanded(
              child: Consumer<MenuType>(
                builder: (BuildContext context, MenuType data, Widget child){
                  if(data.menuList == MenuList.clock)
                    return ClockPage();
                  else if(data.menuList == MenuList.alarm)
                    return AlarmPage();
                  else if(data.menuList == MenuList.timer)
                    return TimerPage();
                  else
                    return StopwatchPage();
                },
              ),
            ),
            VerticalDivider(
              color: Colors.black,
              width: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: list
                  .map((currentMenu) => buildingMenu(currentMenu))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildingMenu(MenuType currentMenu) {
    return Consumer<MenuType>(
      builder: (BuildContext context, MenuType data, Widget child){
        return FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
            color: currentMenu.menuList == data.menuList ? Colors.white60 : Colors.transparent,
            onPressed: () {
              //using the object that was created for menu_model ie MenuType
              //instance of menu info
              var menuType = Provider.of<MenuType>(context, listen: false);
              menuType.updatingMenu(currentMenu);
            },
            child: Column(
              children: [
                Image.asset(currentMenu.imgSource, scale: 12,),
                SizedBox(
                  height: 14,
                ),
                Text(
                  currentMenu.title ?? '',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )
              ],
            ));
      },
    );
  }
}
