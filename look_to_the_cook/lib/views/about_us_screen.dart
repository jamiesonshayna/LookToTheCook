import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// TEMPLATE COMPONENTS:
import 'package:look_to_the_cook/templates/app_bar_component.dart';
import 'package:look_to_the_cook/templates/constants.dart';
import 'package:look_to_the_cook/templates/icon_sm.dart';
import 'package:look_to_the_cook/templates/normal_text.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 01/30/2020
Last Modified: 02/02/2020
File Name: about_us_screen.dart
Version: 2.0
Description: The purpose of this file is to build and render the about us
screen. The screen displays a photo followed by the developer's name, then
below that in another row includes GitHub, LinkedIn, and email links.
This is Followed by a brief statement bout the developer.
 */

class AboutUsScreen extends StatelessWidget {
  static const String id = 'aboutus_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize( // build App Bar
        preferredSize: Size.fromHeight(125.0),
        child: AppBarComponent(
          title: 'ABOUT US',
          leftIcon: Icon(Icons.arrow_back_ios),
          invisibleRightIcon: true,
          leftOnPressed: () {
            Navigator.pop(context); // go back to settings_screen.dart
          },
        ),
      ),
      body: SingleChildScrollView( // scrollable page for overflow
          child: Stack(

          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ), // to space between the appbar and text
                NormalText(
                  text: "Meet The Team",
                  textSize: 24,
                  textColor : Colors.black,
                ),
                SizedBox(
                  height: 30.0,
                  width: 200.0,
                  child: Divider(
                    color: kRedButtonColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: CircleAvatar(
                    radius: 75.0,
                    backgroundImage: AssetImage('images/js_prof.png'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only( top: 10.0),
                  child: NormalText(
                    text: "Shayna Jamieson",
                    textSize: 16,
                    textColor : Colors.black,
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconSM(
                        link: 'https://github.com/jamiesonshayna',
                        whichIcon: FontAwesomeIcons.github,
                      ),
                      IconSM(
                        link: 'mailto:jamieson.shayna@gmail.com',
                        whichIcon: FontAwesomeIcons.solidEnvelope,
                      ),
                      IconSM(
                        link: 'https://www.linkedin.com/in/shayna-jamieson/',
                        whichIcon: FontAwesomeIcons.linkedin,
                      ),

                    ]),
                Padding(
                  padding:
                    const EdgeInsets.only(left: 25.0, right: 25.0, top: 5.0),
                  child: NormalText(
                    text: "Software Developer -- "
                        "Leveraging cultivated knowledge && an eagerness to"
                        " absorb new tricks/technologies.",
                    textSize: 16,
                    textColor : Colors.black,
                  ),
                ),

                SizedBox(
                  height: 45.0,
                ),

                CircleAvatar(
                  radius: 75.0,
                  backgroundImage: AssetImage('images/rw_prof.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: NormalText(
                    text: "Robert Wood Jr",
                    textSize: 16,
                    textColor : Colors.black,
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconSM(
                        link: 'https://github.com/woodrdk',
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
                Padding(
                  padding:
                    const EdgeInsets.only(
                        left: 25.0, top: 5.0, right: 25.0, bottom: 75.0),
                  
                  child: NormalText(
                    text: "Software developer embarking into the tech industry "
                        "to make a difference in lives.",
                    textSize: 16,
                    textColor : Colors.black,
                  ),
                ),
              ],
            ),
          ],
          ),
      )
    );
  }
}

