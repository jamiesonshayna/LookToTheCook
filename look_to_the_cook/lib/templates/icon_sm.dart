import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';


/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 02/01/2020
Last Modified: 02/02/2020
File Name: icon_sm.dart
Version: 2.0
Description: The purpose of this file is to build a widget that based on the
info sent build a social media icon and link to te proper social media
corresponding to the user and the one chose.
 */

class IconSM extends StatelessWidget {
  final String link;
  final IconData whichIcon;
  IconSM(
    { // requires to know what media icon you want & the address of the link
      // that it will take you to.
      @required this.link,
      @required this.whichIcon,
    });

  Widget build(BuildContext context) {
      return new IconButton(
        // Use the FontAwesomeIcons class for the IconData
          icon: new Icon(whichIcon),
          color: Colors.red,
          onPressed: () {
            // when pressed will launch the url supplied to the link
            _launchURL(link);
          }
      );
  }
  // this is used to launch the links to the social media platforms
  _launchURL(String url) async {
    launch(url);
  }
}
