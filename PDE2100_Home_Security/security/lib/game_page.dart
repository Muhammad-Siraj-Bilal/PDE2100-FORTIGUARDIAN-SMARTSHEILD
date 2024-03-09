//This Flutter page displays a screen that allows users to view real-time sensor information.
//It uses the FirebaseDatabase instance to monitor changes in sensor data saved in the
//Firebase Realtime Database. When new data is received, the user interface is updated accordingly.
//It also contains a FloatingActionButton, which allows users to manually trigger a database update for
//testing purposes. If the fire sensor detects a fire (as represented by the value '0'),
//a local notification is issued using FlutterLocalNotificationsPlugin to alert the user to take
//appropriate action.

import 'package:flutter/material.dart';
//import 'package:security/constraints.dart';
//import 'package:security/resueable_box.dart';
//import 'package:security/box_content.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'dart:convert'; //Dart library for encoding and decoding JSON and UTF-8.
//import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:async'; //Dart library for working with asynchronous programming.
//import 'dart:typed_data'; //Facilitating manipulation and handling of sequences of bytes
//import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  late final stream = FirebaseDatabase.instance.ref('Values').onValue;

  int counter = 0;

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor Values'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          DatabaseReference ref = FirebaseDatabase.instance.ref('Values');
          await ref.set({
            'Distance': '32',
            'Fire': '0', // Fire value here changed to test the notification
            'Light': '71',
          });
        },
      ),
      body: Center(
        child: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data?.snapshot.value as Map?;
              if (data == null) {
                return Text('No data');
              }
              final Distance = data['Distance'];
              final Fire = data['Fire'];
              final Light = data['Light'];

              if (Fire == '0') {
                sendNotification();
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildBox('Motion', Distance),
                  _buildBox('Fire', Fire),
                  _buildBox('Light', Light),
                ],
              );
            }
            if (snapshot.hasError) {
              print(snapshot.error.toString());
              return Text(snapshot.error.toString());
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget _buildBox(String label, dynamic value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        // Centering the Column widget
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$label: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '$value',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Fire Detected!',
      'Please take necessary action.',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
}
