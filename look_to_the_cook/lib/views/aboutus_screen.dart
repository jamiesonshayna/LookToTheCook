import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// TEMPLATE COMPONENTS:
import 'package:look_to_the_cook/templates/app_bar_component.dart';
import 'package:look_to_the_cook/templates/icon_sm.dart';
import 'package:look_to_the_cook/templates/normal_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
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
            SizedBox(
              height: 20.0,
            ),
            NormalText(
              text: "The Developers",
              textSize: 18,
              textColor : Colors.black,
            ),
            SizedBox(
              height: 20.0,
              width: 200.0,
              child: Divider(
                color: Colors.black,
              ),
            ),
            CircleAvatar(
              radius: 75.0,
              backgroundImage: AssetImage('images/js_prof.png'),
            ),
            NormalText(
              text: "Shayna Jamieson",
              textSize: 16,
              textColor : Colors.black,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                IconSM(
                  link: 'https://github.com/jamiesonshayna',
                  whichIcon: FontAwesomeIcons.github,
                ),

                IconSM(
                    link: 'mailto:sjamieson2@mail.greenriver.edu',
                    whichIcon: FontAwesomeIcons.solidEnvelope,
                ),
                  IconSM(
                    link: 'https://www.linkedin.com/in/shayna-jamieson/',
                    whichIcon: FontAwesomeIcons.linkedin,
                  ),

        ]),
            NormalText(
              text: "   test to add ",
              textSize: 14,
              textColor : Colors.black,
            ),

            SizedBox(
              height: 50.0,
            ),

            CircleAvatar(
              radius: 75.0,
              backgroundImage: AssetImage('images/rw_prof.jpg'),
            ),
            NormalText(
              text: "Rob Wood",
              textSize: 14,
              textColor : Colors.black,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  IconSM(
                    link: 'https://github.com/jamiesonshayna',
                    whichIcon: FontAwesomeIcons.github,
                  ),

                  IconSM(
                    link: 'mailto:rdrwood@gmail.com',
                    whichIcon: FontAwesomeIcons.solidEnvelope,
                  ),
                  IconSM(
                    link: 'https://www.linkedin.com/in/robert-wood-jr-rdk/',
                    whichIcon: FontAwesomeIcons.linkedin,
                  ),

                ]),
            NormalText(
              text: "Software development student currently in my junior year, "
                  "preparing to embark on the tech industry as a software "
                  "developer.",
              textSize: 16,
              textColor : Colors.black,
            ),
          ]
      )
    );
  }
  _launchURL(String url) async {
    launch(url);
  }
}

