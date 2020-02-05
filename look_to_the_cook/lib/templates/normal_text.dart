import 'package:flutter/material.dart';

/*
Authors: Shayna Jamieson & Rob Wood
Date Created: 1/30/2020
Last Modified: 2/04/2020
File Name: normal_text.dart
Version: 2.0

Description: This file creates our Normal Text Component that is used app-wide. This allows us to
save space on view screens by simply calling this class and passing parameters to render simple text.
The NormalText class can be used on buttons, title, i.e anywhere throughout all of the screens. To use
this component, import this dart file on the page where you would like to use it and instantiate
the NormalText() (required params: text, textSize).
 */

class NormalText extends StatelessWidget {
  // custom properties to create normal text
  final String text; // actual text displayed
  final double textSize;
  final Color textColor;
  final TextAlign textAlign;

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