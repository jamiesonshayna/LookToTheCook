import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 02/01/2020
Last Modified: 02/02/2020
File Name: icon_sm.dart
Version: 2.0
Description: The purpose of this file is to build a widget that will build social media icons with actions
with inputted parameters and instantiation. The class will render an icon that takes the user
to the associated link on click action. To use this component, import this dart file on the page where you
would like to use it and instantiate the IconSM() (required params: link, whichIcon).
 */
class IconSM extends StatelessWidget {
  final String link; // where the user will be taken to on click action
  final IconData whichIcon; // icon that gets displayed on UI

  // construct the icon object for rendering
  IconSM({@required this.link, @required this.whichIcon,});

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
    try {
      if(await canLaunch(url)) {
        await launch(url);
      }
    } catch(e) {
      print(e);
    }
  }
}