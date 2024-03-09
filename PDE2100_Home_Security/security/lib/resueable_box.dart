//The code below shows a reusable card widget named ReusableCard. It accepts arguments for
//the colour, child widget, and an optional onPress method for tap events. Inside the construct method,
//it returns a GestureDetector wrapped around a Container that contains the child widget.
//The container's styling includes the specified colour and border radius, resulting in a
//rounded card appearance. When tapped, the onPress function is activated if given.
//Overall, it has a customisable card with a tap option for usage across the application.

import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({required this.colour, required this.cardChild, this.onPress});

  final Color colour;
  final Widget cardChild; // allows for adding child to custom widget
  final Function()? onPress; // function to be called when widget is pressed

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: colour, // when using box decoration, color goes in here
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
