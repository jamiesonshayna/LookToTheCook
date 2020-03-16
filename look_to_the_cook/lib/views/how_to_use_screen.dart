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
                    NormalText(text: 'Look To The Cook is your new pantry tracking app, thanks for'
                        ' joining us!',
                        textSize: 20.0, textAlign: TextAlign.center, textColor: Colors.black),
                    SizedBox(height: 20.0),
                    NormalText(text: 'Before you get started we\'ll walk you through a few of the important features.',
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
                    NormalText(text: 'To start adding new inventory items you\’ll want to click on the ‘My Inventory’ button from your home '
                        'screen. To add your first item, you\’ll want to fill out at least the item name, quantity, and shopping '
                        'list alert quantity. These fields can be found at the top of the screen. For example, I would add Item Name: Mac N Cheese, Brand: Kraft, '
                        'Size: 1 box, Add To Shopping At: 1 (qty), Inventory Quantity: 3 (this is how many I have on hand). You may also '
                        'add any notes about items if you wish. Once you have filled out your item field’s you\’ll click on the '
                        'plus symbol in the app bar- this saves your item and now it appears in your Inventory List. To delete an item, you simply have to press the ‘trash’ '
                        'icon next to the item that you wish to delete. If you want to update notes or just made a mistake- you can click on the item that you '
                        'want to update in your inventory list which populates the item’s data at the top of the screen. You can edit the item and click update'
                        ' when you are finished or cancel if you have changed your mind. When you deplete an item’s quantity, say by using some of it in a recipe you can '
                        'use the ‘-1 Used’ button to bring the items inventory count down. When you reach your Add To Shopping List number this item will show up in shopping '
                        'list as needing to be purchased. If your list fails to update you can use the refresh icon in the top right of the screen to repopulate inventory items.',
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
                    NormalText(text: 'To start shopping you\’ll want to click on the ‘Shopping List’ button from your home screen. Starting near the middle'
                        ' of the screen you will see items that are in your shopping list that need to be purchased in order to replenish inventory. Once you '
                        'decide to purchase an item you can click on its row, update the ‘Buy’ data field with how many you are purchasing, click update, and'
                        ' then click on the ‘shopping cart’ icon. Once this has been done the item will be automatically populated back in your inventory. If '
                        'you don’t have an item in inventory but wish to put it on your shopping list, you can follow the same steps for adding a new item to inventory '
                        '(but on the shopping list screen). If you delete an item on the shopping screen it will also be deleted from inventory.',
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