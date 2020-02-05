import 'package:flutter/material.dart';

// TEMPLATE COMPONENTS:
import 'package:look_to_the_cook/templates/app_bar_component.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 01/30/2020
Last Modified: 02/04/2020
File Name: profile_screen.dart
Version: 2.0
Description: The purpose of this file is to build and render the user profile screen.
This screen will display the user profile information such as username, email, and
any set preferences. On this screen the user will be able to choose to reset a password, or
cancel/delete their account.
 */

// TODO: Setup password reset/cancellation as well as grab user data (remote).


class ProfileScreen extends StatelessWidget {
  static const String id = 'profile_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125.0),
        child: AppBarComponent(
          title: 'PROFILE',
          leftIcon: Icon(Icons.arrow_back_ios),
          invisibleRightIcon: true,
          leftOnPressed: () {
            Navigator.pop(context); // go back to settings_screen
          },
        ),
      ),
    );
  }
}
