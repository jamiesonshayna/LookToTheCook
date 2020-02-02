import 'package:flutter/material.dart';

// TEMPLATE COMPONENTS:
import 'package:look_to_the_cook/templates/app_bar_component.dart';
import 'package:look_to_the_cook/templates/user_settings_row_listener.dart';

// ROUTES
import 'package:look_to_the_cook/views/profile_screen.dart';
import 'package:look_to_the_cook/views/howtouse_screen.dart';
import 'package:look_to_the_cook/views/aboutus_screen.dart';
import 'package:look_to_the_cook/views/landing_screen.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 01/30/2020
Last Modified: 02/01/2020
File Name: settings_screen.dart
Version: 2.0
Description: The purpose of this file is to build and render the user settings screen.
This screen allows the user to navigate to their profile, how to use page, about us page,
and logout of the application.
 */

class SettingsScreen extends StatelessWidget {
  static const String id = 'settings_screen';

  // finals to set text and icon sizes for all of the rows on the settings page
  final double textSize = 22.0;
  final double iconSize = 40.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125.0),
        child: AppBarComponent(
          title: 'SETTINGS',
          leftIcon: Icon(Icons.arrow_back_ios),
          invisibleRightIcon: true,
          leftOnPressed: () {
            Navigator.pop(context); // go back to landing_screen
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: UserSettingsRowListener(
                    onTap: () {
                      Navigator.pushNamed(context, ProfileScreen.id);
                    },
                    textSize: textSize,
                    iconSize: iconSize,
                    textDisplayed: 'MY PROFILE',
                    iconDisplayed: Icons.person,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                        Border(bottom: BorderSide(color: Colors.black))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: UserSettingsRowListener(
                    onTap: () {
                      Navigator.pushNamed(context, HowToUseScreen.id);
                    },
                    textSize: textSize,
                    iconSize: iconSize,
                    textDisplayed: 'HOW TO USE',
                    iconDisplayed: Icons.info,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                        Border(bottom: BorderSide(color: Colors.black))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: UserSettingsRowListener(
                    onTap: () {
                      Navigator.pushNamed(context, AboutUsScreen.id);
                    },
                    textSize: textSize,
                    iconSize: iconSize,
                    textDisplayed: 'ABOUT US',
                    iconDisplayed: Icons.code,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                        Border(bottom: BorderSide(color: Colors.black))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: UserSettingsRowListener(
                    onTap: () {
                      Navigator.pushNamed(context, LandingScreen.id);
                    },
                    textSize: textSize,
                    iconSize: iconSize,
                    textDisplayed: 'LOGOUT',
                    iconDisplayed: Icons.exit_to_app,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                        Border(bottom: BorderSide(color: Colors.black))),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
