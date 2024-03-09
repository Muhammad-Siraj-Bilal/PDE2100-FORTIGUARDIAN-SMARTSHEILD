//This Flutter page includes a Scaffold widget with an AppBar and a body with two ReusableCard widgets
//arranged in a column arrangement. Each ReusableCard has an icon and a label that reflect distinct
//aspects of the program. When a user taps on a ReusableCard, it takes them to another page via
//the Navigator class and the '/input' or '/game' routes.

import 'package:flutter/material.dart';
import 'package:security/constraints.dart';
import 'package:security/resueable_box.dart';
import 'package:security/box_content.dart';
//import 'package:flutter_application_1/bluetooth.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirtPageState createState() => _FirtPageState();
}

class _FirtPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage your Home Security'),
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
                        icon: Image.asset('assets/door-lock.png',
                            color: Colors.white),
                        label: 'VIRTUAL ACCESS'),
                    onPress: () {
                      Navigator.pushNamed(context, '/input');
                    },
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kReusableCardColor,
                    cardChild: BoxContent(
                        icon: Image.asset('assets/speedometer.png',
                            color: Colors.white),
                        label: 'SENSOR VALUES'),
                    onPress: () {
                      Navigator.pushNamed(context, '/game');
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
}
