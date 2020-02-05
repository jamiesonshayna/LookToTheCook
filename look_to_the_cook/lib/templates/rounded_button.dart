import 'package:flutter/material.dart';

/*
Authors: Shayna Jamieson & Rob Wood
Date Created: 1/30/2020
Last Modified: 2/04/2020
File Name: rounded_button.dart
Version: 2.0

Description: This file creates our Rounded Button component that is used app-wide. This allows
the user to render a button with action with much less code on the views screens. Required params
for this class are the click action as well as the title that is displayed. User can also set
different colors for the text, button background, and text size. To use this component, import this
dart file on the page where you would like to use it and instantiate RoundedButton().
 */

class RoundedButton extends StatelessWidget {
  // custom properties for the rounded button class
  final Color buttonColor;
  final Color buttonTextColor;
  final String title;
  final Function onPressed;
  final double fontSize;

  // constructor for the component that creates button on render
  RoundedButton(
      {this.buttonColor,
        this.buttonTextColor,
        this.fontSize,
        @required this.onPressed,
        @required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding( // top and bottom padding always
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Material(
        elevation: 6.0,
        color: buttonColor, // color of button background
        borderRadius: BorderRadius.circular(20.0),
        child: MaterialButton(
          onPressed: onPressed, // action on button click
          minWidth: 200.0,
          height: 40.0,
          child: Text(
            title,
            style: TextStyle( // style button text
              fontSize: fontSize != null ? fontSize : 25.0,
              color: buttonTextColor != null
                  ? buttonTextColor
                  : Colors.red, // button is red unless otherwise specified
            ),
          ),
        ),
      ),
    );
  }
}
