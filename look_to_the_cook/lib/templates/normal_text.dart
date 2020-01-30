import 'package:flutter/material.dart';

/*
Authors: Shayna Jamieson & Rob Wood
Date Created: 1/30/2019
Last Modified: 1/30/2019
File Name: normal_text.dart
Version: 1.0

Description: This file is part of the templates directory.
 */

class NormalText extends StatelessWidget {
  // properties that can be set to customize
  final String text;
  final double textSize;
  final Color textColor;
  final TextAlign textAlign;

  // constructor for the component that inputs the params given
  NormalText(
      {@required this.text,
        @required this.textSize,
        this.textColor,
        this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        textAlign: textAlign != null ? textAlign : TextAlign.center, // center text unless specified
        style: TextStyle(
          color: textColor != null ? textColor : Colors.white, // color text white unless specified
          fontSize: textSize,
        ),
      ),
    );
  }
}