import 'package:flutter/material.dart';

// TEMPLATE COMPONENTS:
import 'package:look_to_the_cook/templates/app_bar_component.dart';
import 'package:look_to_the_cook/templates/rounded_button.dart';
import 'package:look_to_the_cook/templates/constants.dart';

// ROUTES:
import 'package:look_to_the_cook/views/settings_screen.dart';
import 'package:look_to_the_cook/views/user_inventory_screen.dart';
import 'package:look_to_the_cook/views/user_shop_screen.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 01/30/2020
Last Modified: 02/01/2020
File Name: home_screen.dart
Version: 2.0
Description: The purpose of this file is to build and render the home screen.
The home screen contains a basic welcome message to the user and buttons to visit
their pantry inventory, check user settings, or go to the shopping list screen.
 */

// TODO: BUILD OUT UI / FUNCTIONALITY / ANIMATION

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize( // create App Bar
        preferredSize: Size.fromHeight(125.0),
        child: AppBarComponent(
          title: 'REGISTER',
          invisibleLeftIcon: true,
          rightIcon: Icon(Icons.person), // user settings icon
          rightOnPressed: () {
            Navigator.pushNamed(context, SettingsScreen.id); // navigate to settings_screen.dart
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center(
              child: Container(
                child: Text( // welcome text
                  'Welcome, User',
                  style: TextStyle(
                    fontSize: 30.0
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RoundedButton(
                    title: 'MY INVENTORY',
                    buttonColor: redButtonColor,
                    buttonTextColor: Colors.white,
                    onPressed: () {
                      // take the user to their inventory screen on button click
                      Navigator.pushNamed(context, UserInvScreen.id);
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RoundedButton(
                    title: 'SHOPPING LIST',
                    buttonColor: redButtonColor,
                    buttonTextColor: Colors.white,
                    onPressed: () {
                      // take the user to their shopping list screen on button click
                      Navigator.pushNamed(context, UserShopScreen.id);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: SizedBox()), // scales spacing nicely
        ],
      ),
    );
  }
}
