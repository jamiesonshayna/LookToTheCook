import 'package:flutter/material.dart';

/*
Authors: Shayna Jamieson & Rob Wood
Date Created: 1/30/2019
Last Modified: 1/30/2019
File Name: rounded_button.dart
Version: 1.0

Description: This file is part of the templates directory.
 */

class RoundedButton extends StatelessWidget {
  // properties for the rounded button that can be unique
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Material(
        elevation: 6.0,
        color: buttonColor,
        borderRadius: BorderRadius.circular(20.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 40.0,
          child: Text(
            title,
            style: TextStyle(
              fontSize: fontSize != null ? fontSize : 25.0,
              color: buttonTextColor != null
                  ? buttonTextColor
                  : Colors.red, // button is orange unless otherwise specified
            ),
          ),
        ),
      ),
    );
  }
}
