//This Flutter page is a screen that allows users to regulate access to a security system.
//It establishes a Bluetooth connection with the HC-05 module by utilising its address.
//The screen shows two ReusableCard widgets, each with an icon and a label. Tapping on the "OPEN DOOR"
//card sends a Bluetooth message to open the door, but tapping on the "ALERT AUTHORITIES" card
//displays a local notification urging the user to contact emergency services.

//import 'dart:convert'; //Dart library for encoding and decoding JSON and UTF-8.
import 'package:flutter/material.dart';
import 'package:security/constraints.dart';
import 'package:security/resueable_box.dart';
import 'package:security/box_content.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:async'; //Dart library for working with asynchronous programming.
import 'dart:typed_data'; //Facilitating manipulation and handling of sequences of bytes
import 'package:flutter/foundation.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:audioplayers/src/audio_cache.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  BluetoothConnection? connection;
  StreamSubscription<Uint8List>? streamSubscription;
  bool isConnecting = true;
  bool get isConnected => connection?.isConnected ?? false;

  String deviceAddress = "98:D3:71:FD:DA:06";

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    BluetoothConnection.toAddress(deviceAddress).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
      });

      streamSubscription = connection!.input!.listen(_onDataReceived);
      streamSubscription!.onDone(() {
        if (isConnected) {
          print('Disconnected remotely!');
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occurred');
      print(error);
    });

    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _onDataReceived(Uint8List data) {
    // String receivedString = String.fromCharCodes(data);
    // print('Received data: $receivedString');
  }

  void _sendMessage(int text) async {
    if (connection == null) {
      print('No connection to a device');
      return;
    }

    if (isConnected) {
      connection!.output.add(Uint8List.fromList([text]));
      await connection!.output.allSent;
      print('Message sent');
    } else {
      print('No device connected');
    }
  }

  @override
  void dispose() {
    // Avoid memory leaks and disconnect properly
    streamSubscription?.cancel(); // Cancel the stream subscription
    if (isConnected) {
      connection!.dispose();
      connection = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Access Control'),
        centerTitle: true, // Set this to true to center the title
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ReusableCard(
                    colour: kReusableCardColor,
                    cardChild: BoxContent(
                        icon:
                            Image.asset('assets/door.png', color: Colors.white),
                        label: 'OPEN DOOR'),
                    onPress: () {
                      _sendMessage(1);
                    },
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kReusableCardColor,
                    cardChild: BoxContent(
                        icon: Image.asset('assets/danger.png',
                            color: Colors.white),
                        label: 'ALERT AUTHOROTIES'),
                    onPress: () {
                      sendNotification();
                      ;
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
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
      'ALERTING AUTHOROTIES!',
      'Please call 999.',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
}
