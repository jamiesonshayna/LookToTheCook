import 'package:flutter/material.dart';
import 'package:look_to_the_cook/classes/secure_storage_class.dart';
import 'package:look_to_the_cook/classes/internet_checker_class.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
        if(tempName.length > 15) {
          welcomeMessage = "Welcome!";
        } else {
          welcomeMessage = "Welcome, " + tempName;
        }
      });
    }

    // because of how flutter words we make an async method inside of a non-async method
    // that lets us get the value and render right when the screen is loaded
    gettingName();
  }

  // for secure storage attributes
  SecureStorage storage = new SecureStorage();

  // user attributes
  String welcomeMessage = "";

  // how to guide method
  void displayHowTo(String description, String buttonText, int number) {
    Alert(
      style: AlertStyle(
        isCloseButton: false, // forces the user to verify
        isOverlayTapDismiss: false, // forces the user to verify
      ),
      context: context,
      title: "HOW TO GUIDE",
      desc: description,
      buttons: [
        DialogButton(
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            if(number == 1) {
              SecureStorage storage = new SecureStorage();
              String userId = await storage.readFromStorage('email');
              await storage.writeToStorage(userId, 'notFirstTime');
              number = number + 1;
              Navigator.pop(context);
              displayHowTo('(2/5)\n‘Add To Shopping At’ is what we use to determine when to move the item to the shopping list. Set this as the lowest quantity that you want on hand for your item. ‘Inventory Quantity’ is how many of a particular item you have on hand. When inventory quantity is equal to or lower than ‘Add To Shopping At‘ quantity, your item will be added to the shopping list.', 'NEXT', number);
            } else if(number == 2) {
              number = number + 1;
              Navigator.pop(context);
              displayHowTo("(3/5)\nIf you wish to delete an item simply click the trash can icon in the same row as the item. If you think that the list is not up to date or slow to load you can prompt the list to reload by clicking the refresh icon in the top right.", 'NEXT', number);
            } else if(number == 3) {
              number = number + 1;
              Navigator.pop(context);
              displayHowTo("(4/5)\nTo update click on an item and you’ll see it’s information load into the top form. Edit any field that you want and when you are finished confirm by clicking ‘Update’, otherwise hit ‘Cancel’ and your changes won’t be saved.", "NEXT", number);
            } else if(number == 4) {
              number = number + 1;
              Navigator.pop(context);
              displayHowTo("(5/5)\nThe ‘Used (-1 Qty)’ button has been added for ease of use. Select your item from the list and click the button to subtract a quantity of 1 as many times as you wish instead of manually updating your quantity.", "CLOSE", number);
            } else if(number == 5) {
              Navigator.pop(context);

              // take the user to their inventory screen on button click
              Navigator.pushNamed(context, UserInvScreen.id);
            }
          },
          width: 120,
          color: Colors.black,
        )
      ],
    ).show();
  }

  void displayHowToShop(String description, String buttonText, int number) {
    Alert(
      style: AlertStyle(
        isCloseButton: false, // forces the user to verify
        isOverlayTapDismiss: false, // forces the user to verify
      ),
      context: context,
      title: "HOW TO GUIDE",
      desc: description,
      buttons: [
        DialogButton(
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            if(number == 1) {
              SecureStorage storage = new SecureStorage();
              String userId = await storage.readFromStorage('email');
              await storage.writeToStorage(userId+'shop', 'notFirstTime');
              number = number + 1;
              Navigator.pop(context);
              displayHowToShop("(2/3)\nTo execute a purchase you will need to click on an item which will load the item’s information into the top field. ‘Current Inventory’ is how many of this item you have on hand, and ‘Buy’ is how many of the item you intend to purchase (default is 1). If you are satisfied with the purchase quantity click on the shopping cart icon next to the item to confirm. If you wish to update the quantity that you are purchasing simply change the ‘Buy’ value and click update to confirm.", "NEXT", number);
            } else if(number == 2) {
              number = number + 1;
              Navigator.pop(context);
              displayHowToShop("(3/3)\nIf at any time you decide that you no longer want an item in inventory and you are not purchasing it again, click the trash can icon in the row of the item that you wish to delete.", "CLOSE", number);
            } else if(number == 3) {
              Navigator.pop(context);

              // take the user to their shopping list screen on button click
              Navigator.pushNamed(context, UserShopScreen.id);
            }
          },
          width: 120,
          color: Colors.black,
        )
      ],
    ).show();
  }

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
              title: welcomeMessage,
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
                        onPressed: () async {
                          // check if internet connection is on (required for inventory actions)
                          if(await new InternetCheckerClass().hasConnection() == true) {
                            // if the user is new to the app we will display the how to alert
                            SecureStorage storage = new SecureStorage();
                            String userId = await storage.readFromStorage('email');
                            if(await storage.readFromStorage(userId) == null) {
                              displayHowTo('(1/5)\nTo add an item start by filling out the top form. For accurate tracking fill out at least the item’s name, ‘Add To Shopping At’, and ‘Inventory Quantity’. When you’re ready to add the item click on plus symbol at the top right.', 'NEXT', 1);
                            } else {
                             Navigator.pushNamed(context, UserInvScreen.id);
                            }
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
                        onPressed: () async {
                          //check for internet needed to query the database
                          if(await new InternetCheckerClass().hasConnection() == true) {
                            // if the user is new to the app we will display the how to alert
                            SecureStorage storage = new SecureStorage();
                            String userId = await storage.readFromStorage('email');
                            if(await storage.readFromStorage(userId+'shop') == null) {
                              displayHowToShop("(1/3)\nItems will be automatically sent to the shopping list based on quantity thresholds that are determined on the inventory screen. If you believe that the list is not up to date you can click on the refresh icon in the top right to reload your data.", 'NEXT', 1);
                            } else {
                              Navigator.pushNamed(context, UserShopScreen.id);
                            }
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
