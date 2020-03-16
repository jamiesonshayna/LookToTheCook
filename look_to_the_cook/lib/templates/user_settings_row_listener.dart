import 'package:flutter/material.dart';
import 'normal_text.dart';

/*
Authors: Shayna Jamieson & Rob Wood
Date Created: 1/30/2020
Last Modified: 2/04/2020
File Name: user_settings_row_listener.dart
Version: 2.0
Description: This file creates our User Settings Row Listener that is used app-wide. This allows us
to create very quick rows on settings_screen.dart. The required parameters are the display text,
the click action (route, logout, etc.), and the icon that is displayed to the right of the text. To
use this component, import this dart file on the page where you would like to use it and instantiate
the UserSettingsRowListener().
 */
class UserSettingsRowListener extends StatelessWidget {
  // properties for custom row listener
  final double textSize;
  final double iconSize;
  final String textDisplayed;
  final Function onTap; // click action
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
      onTap: onTap, // allows click action param to be passed
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 25.0),
            child: NormalText( // text displayed in the row
              text: textDisplayed,
              textSize: textSize,
              textColor: Colors.black,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Icon( // icon UI
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