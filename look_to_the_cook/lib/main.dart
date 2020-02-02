import 'package:flutter/material.dart';
import 'views/landing_screen.dart';
import 'views/registration_screen.dart';
import 'views/home_screen.dart';
import 'views/settings_screen.dart';
import 'views/profile_screen.dart';
import 'views/howtouse_screen.dart';
import 'views/aboutus_screen.dart';
import 'views/userinv_screen.dart';
import 'views/usershop_screen.dart';


void main() => runApp(LookToTheCookApp());

class LookToTheCookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Lato', // sets the app-wide font
      ),
      initialRoute: LandingScreen.id, // initial route when the app is loaded
      // navigation
      routes: {
        LandingScreen.id: (context) => LandingScreen(),
        RegistrationScreen.id:(context) => RegistrationScreen(),
        HomeScreen.id: (context) =>HomeScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        HowToUseScreen.id: (context) => HowToUseScreen(),
        AboutUsScreen.id: (context) => AboutUsScreen(),
        UserInvScreen.id: (context) => UserInvScreen(),
        UserShopScreen.id: (context) => UserShopScreen(),

      },
    );
  }
}
