import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

/*
Authors: Shayna Jamieson & Rob Wood
Date Created: 3/15/2020
Last Modified: 3/15/2020
File Name: auto_size_text.dart
Version: 1.0
Description: This file creates our Auto-sized text that is used to scale text. This is
used on the home screen to scale the welcome message if the user has a long name that
floats off of the end of the app bar component. It is also used to scale text on the user
profile screen, as well as inventory/shopping list screens.
 */
class AutoSizeTextClass extends StatelessWidget{
  final String text;
  final int maxLines;
  final Color textColor;
  final double minFontSize;
  final TextAlign alignment;

  AutoSizeTextClass({@required this.text, this.maxLines, this.textColor, this.minFontSize, this.alignment});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AutoSizeText(
        text,
        maxFontSize: 50.0,
        minFontSize: minFontSize == null ? 13.0 : minFontSize,
        maxLines: maxLines == null ? 10 : maxLines,
        textAlign: alignment == null ? TextAlign.center : alignment,
        style: TextStyle(
            color: textColor == null ? Colors.black : textColor
        ),
      ),
    );
  }
}