import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../clock_view.dart';

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  @override
  Widget build(BuildContext context) {

    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (!timezoneString.startsWith('-')) offsetSign = '+';
    print(timezoneString);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Clock',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 32),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                formattedTime,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 40),
              ),
              Text(
                formattedDate,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
            ],
          ),
          SizedBox(height: 12,),
          Align(
            alignment: Alignment.center,
            child: ClockDesign(
              size: MediaQuery.of(context).size.height / 4,
            ),
          ),
          SizedBox(height: 12,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Timezone',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 24),
              ),
              SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.language,
                    color: Colors.black,
                  ),
                  SizedBox(width: 16),
                  Text(
                    'UTC' +' '+ offsetSign +' '+ timezoneString,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

