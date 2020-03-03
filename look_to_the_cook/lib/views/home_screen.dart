import 'package:flutter/material.dart';
import 'package:look_to_the_cook/classes/secure_storage_class.dart';

// TEMPLATE COMPONENTS:
import 'package:look_to_the_cook/templates/app_bar_component.dart';
import 'package:look_to_the_cook/templates/rounded_button.dart';
import 'package:look_to_the_cook/templates/constants.dart';
import 'package:look_to_the_cook/templates/background_container_image.dart';

// ROUTES:
import 'package:look_to_the_cook/views/settings_screen.dart';
import 'package:look_to_the_cook/views/user_inventory_screen.dart';
import 'package:look_to_the_cook/views/user_shop_screen.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 01/30/2020
Last Modified: 02/02/2020
File Name: home_screen.dart
Version: 3.0
Description: The purpose of this file is to build and render the home screen.
The home screen contains a basic welcome message to the user and buttons to visit
their pantry inventory, check user settings, or go to the shopping list screen.
 */

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // upon screen render we want to display the users name and welcome message
  @override
  void initState() {
    super.initState();
    setUserName();
  }

  /*
  This method allows us to render the user's correct name in the welcome message.
  Because we do this at the point of screen rendering, we have to make a call to this
  method after initState(). We get the name from secure storage and display on the page.
   */
  setUserName() {
    gettingName() async {
      var name = await storage.readFromStorage("name");
      String tempName = name.toString();
      tempName = tempName.split(" ").first;
      setState(() {
        userName = tempName;
      });
    }

    // because of how flutter words we make an async method inside of a non-async method
    // that lets us get the value and render right when the screen is loaded
    gettingName();
  }

  // for secure storage attributes
  SecureStorage storage = new SecureStorage();

  // user attributes
  String userName = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: kRedButtonColor,
        appBar: PreferredSize( // create App Bar
          preferredSize: Size.fromHeight(125.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: AppBarComponent(
              title: 'Welcome, ' + userName,
              invisibleLeftIcon: true,
              rightIcon: Icon(Icons.person), // user settings icon
              rightOnPressed: () {
                Navigator.pushNamed(context, SettingsScreen.id); // navigate to settings_screen.dart
              },
            ),
          ),
        ),
        body: BackgroundContainerImage(
          image: 'images/homepage_bg.png',
          child: Column(
            children: <Widget> [
//              Padding(
//                padding: const EdgeInsets.only(top: 40.0),
//                child: Center(
//                  child: Container(
//                    child: Text( // welcome text
//                      'Welcome, '+ userName,
//                      style: TextStyle(
//                        fontSize: 30.0
//                      ),
//                    ),
//                  ),
//                ),
//              ),
            SizedBox(
              height: 25.0,
              child: Container(
                color: kRedButtonColor,
              ),
            ),
              Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RoundedButton(
                        title: 'MY INVENTORY',
                        buttonColor: kRedButtonColor,
                        buttonTextColor: Colors.white,
                        onPressed: () {
                          // take the user to their inventory screen on button click
                          Navigator.pushNamed(context, UserInvScreen.id);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RoundedButton(
                        title: 'SHOPPING LIST',
                        buttonColor: kRedButtonColor,
                        buttonTextColor: Colors.white,
                        onPressed: () {
                          // take the user to their shopping list screen on button click
                          Navigator.pushNamed(context, UserShopScreen.id);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: SizedBox()), // scales spacing nicely
            ],
          ),
        ),
      ),
    );
  }
}
