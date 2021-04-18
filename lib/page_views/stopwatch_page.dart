import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {

  bool startIsPressed = true;
  bool stopIsPressed = true;
  bool resetIsPressed = true;
  String timeTiDisplay = '00:00:00';
  var stopwatch = Stopwatch();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Stopwatch',
            style: TextStyle(
                color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: Text(timeTiDisplay, style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 32
              ),),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RaisedButton(
                        onPressed: stopIsPressed ? null : stop,
                        elevation: 5,
                        color: Colors.red,
                        child: Text(
                          'Stop',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      RaisedButton(
                        onPressed: resetIsPressed ? null : reset,
                        elevation: 5,
                        color: Colors.redAccent,
                        child: Text(
                          'Reset',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ],
                  ),
                  RaisedButton(
                    onPressed: startIsPressed ? start : null,
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  //starting timer
  void startTimer(){
    Timer(Duration(seconds: 1), keepRunning);
  }

  void keepRunning(){
    if(stopwatch.isRunning){
      startTimer();
    }
    setState(() {
      timeTiDisplay = stopwatch.elapsed.inHours.toString().padLeft(2, "0") + ":" +
          (stopwatch.elapsed.inMinutes%60).toString().padLeft(2, "0") + ":" +
          (stopwatch.elapsed.inSeconds%60).toString().padLeft(2, "0");
    });
  }

  void start(){
    setState(() {
      stopIsPressed = false;
      startIsPressed = false;
    });
    stopwatch.start();
    startTimer();
  }

  void stop(){
    setState(() {
      stopIsPressed = true;
      resetIsPressed = false;
    });
    stopwatch.stop();
  }

  void reset(){
    setState(() {
      startIsPressed = true;
      resetIsPressed = true;
    });
    stopwatch.reset();
    timeTiDisplay = '00:00:00';
  }
}
