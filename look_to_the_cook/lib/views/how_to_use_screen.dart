import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// TEMPLATE COMPONENTS:
import 'package:look_to_the_cook/templates/app_bar_component.dart';
import 'package:look_to_the_cook/templates/normal_text.dart';
import 'package:look_to_the_cook/templates/constants.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 01/30/2020
Last Modified: 02/25/2020
File Name: how_to_use_screen.dart
Version: 3.0
Description: The purpose of this file is to give the user a general-use guideline. Here
we will point out the features of the application, and their purposes. We will give small
instruction on how the inventory and shopping screens work as well as a general welcome. This
screen also provides an email to 'customer service' if the user is experiencing more trouble.
 */


class HowToUseScreen extends StatelessWidget {
  static const String id = 'howtouse_screen';

  /*
  This method allows the user to email 'customer service'

  The URL launcher will bring up the respective mailing tool for the
  user's device and allow them to send issue tickets, comments, etc.
   */
  _launchEmail() async {
    final String email = 'mailto:jamieson.shayna@gmail.com?subject=Help%20Desk&body=';
    final String url = 'https://mail.google.com/mail/?view=cm&fs=1&to=jamieson.shayna@gmail.com&su=SERVICE';

    try {
      if(await canLaunch(email)) {
        await launch(email);
      } else {
        launch(url);
      }
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125.0),
        child: AppBarComponent(
          title: 'HOW TO USE',
          leftIcon: Icon(Icons.arrow_back_ios),
          invisibleRightIcon: true,
          leftOnPressed: () {
            Navigator.pop(context); // go back to settings_screen
          },
        ),
      ),
      body: SingleChildScrollView( // scrollable page for overflow
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 25.0),
                child: Column(
                  children: <Widget>[
                    NormalText(text: 'Look To The Cook is the premier pantry tracking app, thanks for'
                        ' joining us!',
                        textSize: 20.0, textAlign: TextAlign.center, textColor: Colors.black),
                    SizedBox(height: 20.0),
                    NormalText(text: 'Before you get started we\'ll walk you through a few of the important features',
                      textSize: 20.0, textAlign: TextAlign.center, textColor: Colors.black),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                      child: Divider(
                        thickness: 1.0,
                        color: kRedButtonColor,
                        height: 30.0,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  children: <Widget>[
                    NormalText(text: 'Inventory', textSize: 20.0, textColor: Colors.black),
                    SizedBox(height: 8.0),
                    NormalText(text: 'The inventory module is where you will add new items that you want to track.'
                        ' When initially adding these items you\'ll set alerts, quantities, sizes, and notes.'
                        ' You can revisit module anytime you would like to add new items, or delete items from your pantry. ',
                      textSize: 15.0, textAlign: TextAlign.center, textColor: Colors.black,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
                child: Column(
                  children: <Widget>[
                    NormalText(text: 'Shopping List', textSize: 20.0, textColor: Colors.black),
                    SizedBox(height: 8.0),
                    NormalText(text: 'When you visit the shopping list module you will be able to view which'
                        ' items currently have alerts and need to be purchased. While you are out and about you will'
                        ' be able to access an up-to-date version of this list and cross off items that you purchase'
                        ' to update your inventory and replenish your pantry.',
                      textSize: 15.0, textAlign: TextAlign.center, textColor: Colors.black,),
                  ],
                ),
              ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
                  child: Column(
                    children: <Widget>[
                      NormalText(text: 'Additional Help', textSize: 20.0, textColor: Colors.black),
                      SizedBox(height: 8.0),
                      NormalText(text: 'We hope that this pantry tracker app makes life easier, and that your experience'
                          ' with the app is great! If you find that you are having issues with your profile, inventory,'
                          ' shopping list, or anything else, please don\'t hesitate to reach out. You may contact our'
                          ' service desk at the follow address: ',
                        textSize: 15.0, textAlign: TextAlign.center, textColor: Colors.black,),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 60.0),
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          // allow user to send email to 'customer service'
                          await _launchEmail();
                        },
                        child: Text.rich(
                          TextSpan(
                            text: 'jamieson.shayna@gmail.com',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.blue,
                              decoration: TextDecoration.underline
                            ),
                          ),
                        ),
                      )
                    ],
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