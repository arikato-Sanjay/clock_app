import 'dart:async';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int hours = 0;
  int min = 0;
  int secs = 0;
  bool started = true;
  bool stopped = true;
  int timeForTimer = 0;
  String timeToDisplay = '';
  bool timerRunning = true;
  String timeLeft = '';
  String start_pause = 'Start';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Timer',
            style: TextStyle(
                color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Expanded(
              flex: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          'Hours',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      NumberPicker.integer(
                          initialValue: hours,
                          minValue: 0,
                          maxValue: 23,
                          listViewWidth: 60,
                          onChanged: (value) {
                            setState(() {
                              hours = value;
                            });
                          })
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          'Mins',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      NumberPicker.integer(
                          initialValue: min,
                          minValue: 0,
                          maxValue: 59,
                          listViewWidth: 60,
                          onChanged: (value) {
                            setState(() {
                              min = value;
                            });
                          })
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          'Secs',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      NumberPicker.integer(
                        onChanged: (value) {
                          setState(() {
                            secs = value;
                          });
                        },
                        initialValue: secs,
                        minValue: 0,
                        maxValue: 59,
                        listViewWidth: 60,
                      ),
                    ],
                  )
                ],
              )),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(timeLeft, style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w300
                ),),
                Text(timeToDisplay, style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w300
                ),)
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                RaisedButton(
                  onPressed: started ? start : null,
                  elevation: 5,
                  color: Colors.green,
                  child: Text(
                    'Start',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                SizedBox(
                  width: 20,
                ),
                RaisedButton(
                  onPressed: stopped ? null : stop,
                  elevation: 5,
                  color: Colors.red,
                  child: Text('Stop',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void start() {
    timeLeft = 'Time left: ';
    setState(() {
      started = false;
      stopped = false;
    });
    timeForTimer = ((hours * 60 * 60) + (min * 60) + secs);
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timeForTimer < 1 || timerRunning == false) {
          t.cancel();
          timerRunning = true;
          timeToDisplay = '';
          timeLeft = '';
          started = true;
          stopped = true;
        } else if (timeForTimer < 60) {
          timeToDisplay = timeForTimer.toString() + ' sec';
          timeForTimer = timeForTimer - 1;
        } else if (timeForTimer < 3600) {
          int m = timeForTimer ~/ 60;
          int s = timeForTimer - (60 * m);
          timeToDisplay = m.toString() + "m :" + s.toString() + ' sec';
          timeForTimer = timeForTimer - 1;
        } else {
          int h = timeForTimer ~/ 3600;
          int t = timeForTimer - (3600 * h);
          int m = t ~/ 60;
          int s = t - (60 * m);
          timeToDisplay =
              h.toString() + "h :" + m.toString() + "m :" + s.toString() + ' sec';
          timeForTimer = timeForTimer - 1;
        }
      });
    });
  }

  void stop() {
    setState(() {
      started = true;
      stopped = true;
      timerRunning = false;
    });
  }
}
