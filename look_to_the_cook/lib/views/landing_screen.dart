import 'package:flutter/material.dart';

// TEMPLATE COMPONENTS:
import 'package:look_to_the_cook/templates/constants.dart';
import 'package:look_to_the_cook/templates/background_container_image.dart';
import 'package:look_to_the_cook/templates/rounded_button.dart';

// ROUTES:
import 'package:look_to_the_cook/views/registration_screen.dart';
import 'package:look_to_the_cook/views/login_screen.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 01/30/2020
Last Modified: 02/01/2020
File Name: landing_screen.dart
Version: 2.0
Description: The purpose of this file is to build and render the landing screen.
This screen is the initial route for the Look To The Cook application. This is a static
screen that simply allows users to choose between logging in or creating a profile.
 */

class LandingScreen extends StatelessWidget {
  static const String id = 'landing_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainerImage(
        image: 'images/new_home_screen.png', // set body background image
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(child: SizedBox(),),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: RoundedButton(
              title: 'LOG IN',
              buttonColor: redButtonColor,
              buttonTextColor: Colors.white,
              onPressed: () {
                // takes the user to the login_screen
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 50.0, top: 10.0),
            child: RoundedButton(
              title: 'REGISTER',
              buttonColor: redButtonColor,
              buttonTextColor: Colors.white,
              onPressed: () {
                // takes the user to the registration_screen
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ),
        ],
        ),
      ),
    );
  }
}
