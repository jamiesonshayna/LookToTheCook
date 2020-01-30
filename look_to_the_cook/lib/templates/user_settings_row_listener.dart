import 'package:flutter/material.dart';
import 'normal_text.dart';

/*
Authors: Shayna Jamieson & Rob Wood
Date Created: 1/30/2019
Last Modified: 1/30/2019
File Name: user_settings_row_listener.dart
Version: 1.0

Description: This file is part of the templates directory.
 */

class UserSettingsRowListener extends StatelessWidget {
  // properties that for the component
  final double textSize;
  final double iconSize;
  final String textDisplayed;
  final Function onTap;
  final IconData iconDisplayed;

  // constructor for the component that executes on render
  UserSettingsRowListener(
      {@required this.textDisplayed,
        @required this.onTap,
        @required this.iconDisplayed,
        this.iconSize,
        this.textSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 25.0),
            child: NormalText(
              text: textDisplayed,
              textSize: textSize,
              textColor: Colors.black,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Icon(
              iconDisplayed,
              color: Colors.red,
              size: iconSize,
            ),
          ),
        ],
      ),
    );
  }
}