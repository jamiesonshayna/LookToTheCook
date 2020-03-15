import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// SCREENS FOR ROUTING:
import 'views/landing_screen.dart';
import 'views/login_screen.dart';
import 'views/forgot_password_screen.dart';
import 'views/registration_screen.dart';
import 'views/home_screen.dart';
import 'views/settings_screen.dart';
import 'views/profile_screen.dart';
import 'views/how_to_use_screen.dart';
import 'views/about_us_screen.dart';
import 'views/user_inventory_screen.dart';
import 'views/user_shop_screen.dart';
import 'views/terms_and_conditions_screen.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 01/30/2020
Last Modified: 03/03/2020
File Name: main.dart
Version: 4.0
Description: This file is the application's main controller. Here we are able to set app-wide fonts,
app orientation settings, initial routes, as well as create ALL of our routes. Defining routes here
allows us to use them on any particular screen to navigate as long as the screen has imported this class.
To make a new route make sure to give that class a constant (and unique!) id, and include it in the
routes section below.
 */
void main() => runApp(LookToTheCookApp());

class LookToTheCookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // sets orientation of the app to be just portrait mode (either normal or upside down)
    // this allows for easier use and better UI responsiveness for all screen sizes
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Lato', // sets the app-wide font
      ),
      initialRoute: LandingScreen.id, // initial route when the app is loaded
      // navigation
      routes: {
        LandingScreen.id: (context) => LandingScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
        HomeScreen.id: (context) =>HomeScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
        ProfileScreen.id: (context) => ProfileScreen(
            userName: '', userEmail: '', userPassword: ''),
        HowToUseScreen.id: (context) => HowToUseScreen(),
        AboutUsScreen.id: (context) => AboutUsScreen(),
        UserInvScreen.id: (context) => UserInvScreen(),
        UserShopScreen.id: (context) => UserShopScreen(),
        TermsAndConditionsScreen.id: (context) => TermsAndConditionsScreen(),
      },
    );
  }
}