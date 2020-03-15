import 'package:flutter/material.dart';
import 'package:look_to_the_cook/classes/login_logout_class.dart';
import 'package:look_to_the_cook/classes/secure_storage_class.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

// TEMPLATE COMPONENTS:
import 'package:look_to_the_cook/templates/constants.dart';
import 'package:look_to_the_cook/templates/background_container_image.dart';
import 'package:look_to_the_cook/templates/rounded_button.dart';

// ROUTES:
import 'package:look_to_the_cook/views/registration_screen.dart';
import 'package:look_to_the_cook/views/login_screen.dart';
import 'package:look_to_the_cook/views/home_screen.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 01/30/2020
Last Modified: 03/02/2020
File Name: landing_screen.dart
Version: 4.0
Description: The purpose of this file is to build and render the landing screen.
This screen is the initial route for the Look To The Cook application. This is a static
screen that simply allows users to choose between logging in, auto logging in,
 or creating a profile.
 */
class LandingScreen extends StatefulWidget {
  static const String id = 'landing_screen';

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  // variable to track loading spinner and toggle
  bool _isLoggingIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainerImage(
        image: 'images/new_home_screen.png', // set body background image
        child: ModalProgressHUD(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: SizedBox(),),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: RoundedButton(
                title: 'LOG IN',
                buttonColor: kRedButtonColor,
                buttonTextColor: Colors.white,
                onPressed: () async {
                  // check if we can automatically move a logged in user to the home screen
                  SecureStorage storage = new SecureStorage();
                  if(await storage.userIsLoggedIn()) {
                    setState(() {
                      _isLoggingIn = true;

                    });

                    // let loading spinner go
                    await new Future.delayed(const Duration(seconds: 1));

                    // attempt to authenticate user and navigate them to the home screen
                    LoginLogout loginHelper = new LoginLogout();

                    if(await loginHelper.autoAuthenticateAndLogin()) {
                      setState(() {
                        _isLoggingIn = false;
                      });
                      // we have authenticated and can navigate
                      Navigator.pushNamed(context, HomeScreen.id);
                    } else { // failed auto-login (needs manual login)
                      setState(() {
                        _isLoggingIn = false;
                      });
                      // takes the user to the login_screen
                      Navigator.pushNamed(context, LoginScreen.id);
                    }
                  } else {
                    // takes the user to the login_screen
                    Navigator.pushNamed(context, LoginScreen.id);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 50.0, top: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RoundedButton(
                      title: 'REGISTER',
                      buttonColor: kRedButtonColor,
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
          ],
          ),
          inAsyncCall: _isLoggingIn,
          dismissible: false,
          progressIndicator: Padding(
            padding: const EdgeInsets.only(top: 250.0),
            child: SpinKitWave(
              color: kRedButtonColor,
            ),
          )
        ),
      ),
    );
  }
}