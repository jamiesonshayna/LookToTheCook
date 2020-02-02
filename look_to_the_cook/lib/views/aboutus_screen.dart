import 'package:flutter/material.dart';

// TEMPLATE COMPONENTS:
import 'package:look_to_the_cook/templates/app_bar_component.dart';

// ROUTES

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 01/30/2020
Last Modified: 02/01/2020
File Name: aboutus_screen.dart
Version: 2.0
Description: The purpose of this file is to build and render the about us screen.
The screen..........
 */

class AboutUsScreen extends StatelessWidget {
  static const String id = 'aboutus_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125.0),
        child: AppBarComponent(
          title: 'ABOUT US',
          leftIcon: Icon(Icons.arrow_back_ios),
          invisibleRightIcon: true,
          leftOnPressed: () {
            Navigator.pop(context); // go back to landing_screen
          },
        ),
      ),
    );
  }
}
