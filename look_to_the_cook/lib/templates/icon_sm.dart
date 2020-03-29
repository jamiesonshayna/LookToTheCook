import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:look_to_the_cook/classes/internet_checker_class.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
          onPressed: () async {
            // check for internet and if none display alert
            if(await new InternetCheckerClass().hasConnection() == true) {
              // when pressed will launch the url supplied to the link
              _launchURL(link);
            } else {
              Alert(
                style: AlertStyle(
                  isCloseButton: false, // forces the user to verify
                  isOverlayTapDismiss: false, // forces the user to verify
                ),
                context: context,
                title: "No internet connection. Please adjust your connection and try again!",
                desc: "",
                buttons: [
                  DialogButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    width: 120,
                    color: Colors.black,
                  ),
                ],
              ).show();
            }
          }
      );
  }

  // this is used to launch the links to the social media platforms
  _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      }
    } catch (e) {
      print(e);
    }
  }
}