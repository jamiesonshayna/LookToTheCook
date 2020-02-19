import 'package:flutter/material.dart';

// TEMPLATE COMPONENTS:
import 'package:look_to_the_cook/templates/app_bar_component.dart';
import'package:look_to_the_cook/templates/constants.dart';
import 'package:look_to_the_cook/templates/rounded_button.dart';

// ROUTES:
import 'package:look_to_the_cook/views/home_screen.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 02/01/2020
Last Modified: 02/04/2020
File Name: login_screen.dart
Version: 2.0
Description: The purpose of this file is to build and render the login screen.
Currently this is just a 'placeholder' to simulate logging in. As long as you enter
something into each of the fields you will be able to login.
 */

// TODO: Add actual authentication, re-comment header, provide error catching

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // listener for the text field user input that allow us to capture user data
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125.0),
        child: AppBarComponent(
          title: 'LOG IN',
          leftIcon: Icon(Icons.arrow_back_ios),
          invisibleRightIcon: true,
          leftOnPressed: () {
            Navigator.pop(context); // go back to landing_screen
          },
        ),
      ),
      body: new GestureDetector(
        onTap: () {
          // lets the user exit text field by tapping background scaffold
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 100.0, left: 10.0, right: 30.0),
                child: Container(
                  child: TextFormField(
                    // validation for email field on login form
                    validator: (value) {
                      if(value == '') {
                        return 'enter an email';
                      } else {
                        return null;
                      }
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kRedButtonColor),
                      ),
                      icon: Padding(
                        padding: const EdgeInsets.only(top:10.0),
                        child: Icon(
                          Icons.mail_outline,
                          color: Colors.black,
                          size: 40.0,
                        ),
                      ),
                      hintText: '',
                      labelText: 'EMAIL',
                      labelStyle: TextStyle(
                        color: kRedButtonColor,
                        fontSize: 18.0,
                      )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 10.0, right: 30.0),
                child: Container(
                  child: TextFormField(
                    // validation for password field on login form
                    validator: (value) {
                      if(value == '') {
                        return 'invalid password';
                      } else {
                        return null;
                      }
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kRedButtonColor),
                        ),
                        icon: Padding(
                          padding: const EdgeInsets.only(top:10.0),
                          child: Icon(
                            Icons.lock_outline,
                            color: Colors.black,
                            size: 40.0,
                          ),
                        ),
                        hintText: '',
                        labelText: 'PASSWORD',
                        labelStyle: TextStyle(
                          color: kRedButtonColor,
                          fontSize: 18.0,
                        )
                    ),
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 200.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RoundedButton(
                        title: 'LOG IN',
                        buttonTextColor: Colors.white,
                        buttonColor: kRedButtonColor,
                        onPressed: () {
                          // if the user input is valid then we take the user to the home_screen
                          if(formKey.currentState.validate()) {
                            setState(() {
                              Navigator.pushNamed(context, HomeScreen.id);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}