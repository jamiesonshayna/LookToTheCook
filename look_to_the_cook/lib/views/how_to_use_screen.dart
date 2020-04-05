import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
class HowToUseScreen extends StatefulWidget {
  static const String id = 'howtouse_screen';

  @override
  _HowToUseScreenState createState() => _HowToUseScreenState();
}

class _HowToUseScreenState extends State<HowToUseScreen> {
  _launchEmail() async {
    final String email = 'mailto:info.looktothecook@gmail.com?subject=Help%20Desk&body=';
    final String url = 'https://mail.google.com/mail/?view=cm&fs=1&to=info.looktothecook@gmail.com&su=Info';

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

  // this is a method that displays appropriate how to results on user click action
  void displayHowTo(String title, String desc) {
    Alert(
      context: context,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
          color: Colors.black,
        )
      ],
    ).show();
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
                    NormalText(text: 'Look To The Cook- your new pantry tracking app, thanks for'
                        ' joining us!',
                        textSize: 19.0, textAlign: TextAlign.center, textColor: Colors.black),
                    SizedBox(height: 20.0),
                    NormalText(text: 'Before you get started click on any of the sections below to view our how to guides and learn about important features.',
                      textSize: 19.0, textAlign: TextAlign.center, textColor: Colors.black),
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'Inventory List',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: GestureDetector(
                        onTap: () {
                          displayHowTo("ADD AN ITEM", "To add an item start by filling out the top form. For accurate tracking fill out at least the item’s name, ‘Add To Shopping At’, and ‘Inventory Quantity’. When you’re ready to add the item click on plus symbol at the top right.");
                        },
                        child: Text(
                          '1. ADD AN ITEM',
                          style: TextStyle(
                            fontSize: 18.0,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: GestureDetector(
                        onTap: () {
                          displayHowTo("QUANTITY ALERTS", "‘Add To Shopping At’ is what we use to determine when to move the item to the shopping list. Set this as the lowest quantity that you want on hand for your item. ‘Inventory Quantity’ is how many of a particular item you have on hand. When inventory quantity is equal to or lower than ‘Add To Shopping At‘ quantity, your item will be added to the shopping list.");
                        },
                        child: Text(
                          '2. LOW QUANTITY ALERTS',
                          style: TextStyle(
                            fontSize: 18.0,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: GestureDetector(
                        onTap: () {
                          displayHowTo("DELETE AN ITEM", "If you wish to delete an item simply click the trash can icon in the same row as the item. If you think that the list is not up to date or slow to load you can prompt the list to reload by clicking the refresh icon in the top right.");
                        },
                        child: Text(
                          '3. DELETE AN ITEM',
                          style: TextStyle(
                            fontSize: 18.0,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: GestureDetector(
                        onTap: () {
                          displayHowTo("UPDATE AN ITEM", "To update click on an item and you’ll see it’s information load into the top form. Edit any field that you want and when you are finished confirm by clicking ‘Update’, otherwise hit ‘Cancel’ and your changes won’t be saved.");
                        },
                        child: Text(
                          '4. UPDATE AN ITEM',
                          style: TextStyle(
                            fontSize: 18.0,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: GestureDetector(
                        onTap: () {
                          displayHowTo("USED -1 BUTTON", "The ‘Used (-1 Qty)’ button has been added for ease of use. Select your item from the list and click the button to subtract a quantity of 1 as many times as you wish instead of manually updating your quantity.");
                        },
                        child: Text(
                          '5. BONUS: USED -1 BUTTON',
                          style: TextStyle(
                            fontSize: 18.0,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'Shopping List',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: GestureDetector(
                        onTap: () {
                          displayHowTo("REFRESH THE LIST", "Items will be automatically sent to the shopping list based on quantity thresholds that are determined on the inventory screen. If you believe that the list is not up to date you can click on the refresh icon in the top right to reload your data.");
                        },
                        child: Text(
                          '1. REFRESHING THE LIST',
                          style: TextStyle(
                            fontSize: 18.0,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: GestureDetector(
                        onTap: () {
                          displayHowTo("UPDATE/PURCHASE", "To execute a purchase you will need to click on an item which will load the item’s information into the top field. ‘Current Inventory’ is how many of this item you have on hand, and ‘Buy’ is how many of the item you intend to purchase (default is 1). If you are satisfied with the purchase quantity click on the shopping cart icon next to the item to confirm. If you wish to update the quantity that you are purchasing simply change the ‘Buy’ value and click update to confirm.");
                        },
                        child: Text(
                          '2. UPDATE/PURCHASE ITEMS',
                          style: TextStyle(
                            fontSize: 18.0,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          'Additional Help',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
                            text: 'info.looktothecook@gmail.com',
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