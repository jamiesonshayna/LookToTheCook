import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// TEMPLATE COMPONENTS:
import 'package:look_to_the_cook/templates/app_bar_component.dart';
import 'package:look_to_the_cook/templates/icon_git.dart';
import 'package:look_to_the_cook/templates/normal_text.dart';
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
      body: Column(
          children: <Widget>[
            NormalText(
              text: "The Developers",
              textSize: 18,
              textColor : Colors.black,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                NormalText(
                  text: "Shayna Jamieson",
                  textSize: 14,
                  textColor : Colors.black,
                ),
                IconGit(
                  link: 'https://github.com/jamiesonshayna',
                ),
                NormalText(
                text: "Rob Wood",
                textSize: 14,
                textColor : Colors.black,
                ),
                IconGit(
                    link: 'https://github.com/woodrdk',
                ),
        ]),
        ]));

  }
}
