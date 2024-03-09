//The Flutter code below defines a BoxContent widget that is utilised within the application.
//It accepts parameters for an icon widget and a label string. Overall, it offers a systematic
//arrangement for displaying an icon and associated text.

import 'package:flutter/material.dart';
import 'package:security/constraints.dart';

class BoxContent extends StatelessWidget {
  BoxContent({required this.icon, required this.label});

  final Widget icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          child: icon,
          //size: 80.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          label,
          style: kLabelTextStyle,
        ),
      ],
    );
  }
}

class BoxContent2 extends StatelessWidget {
  BoxContent2({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 80.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          label,
          style: kLabelTextStyle2,
        ),
      ],
    );
  }
}
