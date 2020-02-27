import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// TEMPLATE COMPONENTS:
import 'package:look_to_the_cook/templates/app_bar_component.dart';
import 'package:look_to_the_cook/templates/normal_text.dart';
import 'package:look_to_the_cook/templates/constants.dart';
import 'package:look_to_the_cook/templates/rounded_button.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 01/30/2020
Last Modified: 02/27/2020
File Name: profile_screen.dart
Version: 3.0
Description: The purpose of this file is to build and render the user profile screen.
This screen will display the user profile information such as username, email, and any
set preferences. On this screen the user will be able to choose to reset a password, or
cancel/delete their account.
 */

// TODO: Setup reroute the user to the reset password page


class ProfileScreen extends StatelessWidget {
  static const String id = 'profile_screen';

  // properties to be displayed
  final String userName;
  final String userEmail;
  final String userPassword;

  ProfileScreen({@required this.userName, @required this.userEmail, @required this.userPassword});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBarComponent(
          title: '',
          leftIcon: Icon(Icons.arrow_back_ios),
          invisibleRightIcon: true,
          leftOnPressed: () {
            Navigator.pop(context); // go back to settings_screen
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: kRedButtonColor,
            height: 150.0,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: NormalText(
                    text: userName,
                    textSize: 35.0,
                  ),
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                child: NormalText(
                  text: 'Email',
                  textColor: Colors.black,
                  textSize: 25.0,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0, bottom: 50.0),
                child: NormalText(
                  text: userEmail,
                  textColor: Colors.black,
                  textSize: 15.0,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
                child: NormalText(
                  text: 'Profile Type',
                  textColor: Colors.black,
                  textSize: 25.0,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0, bottom: 50.0),
                child: NormalText(
                  text: 'Active membership',
                  textColor: Colors.black,
                  textSize: 15.0,
                ),
              ),
            ],
          ),

          Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RoundedButton(
                    title: 'RESET PASSWORD',
                    buttonTextColor: Colors.white,
                    buttonColor: kRedButtonColor,
                    onPressed: () {
                      // navigate to reset password screen ?

                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 40.0),
            child: GestureDetector(
              onTap: () {
                // logic to delete account
              },
              child: NormalText(
                text: 'Permanently Delete Account',
                textColor: Colors.red,
                textSize: 15.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
