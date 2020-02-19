import 'package:flutter/material.dart';

// TEMPLATE COMPONENTS:
import 'package:look_to_the_cook/templates/rounded_button.dart';
import 'package:look_to_the_cook/templates/app_bar_component.dart';
import 'package:look_to_the_cook/templates/constants.dart';

// ROUTES:
import 'package:look_to_the_cook/views/home_screen.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 01/30/2020
Last Modified: 02/04/2020
File Name: registration_screen.dart
Version: 2.0
Description: The purpose of this file is to build and render the registration screen.
Currently this is just a 'placeholder' to simulate creating a profile. As long as you enter
something into each of the fields you will be able to register.
 */

// TODO: Create actual registration process with remote db communication
// TODO: Store user credentials in database on successful registration?
// TODO: Add registration confirmation email????

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  // listener for the text field user input that allow us to capture user data
  final formKey = GlobalKey<FormState>();

  String userEmail;
  String userPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125.0),
        child: AppBarComponent(
          title: 'REGISTER',
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
                padding: const EdgeInsets.only(top: 50.0, left: 10.0, right: 30.0),
                child: Container(
                  child: TextFormField(
                    // validation for name field on login form
                    validator: (value) {
                      if(value == '') {
                        return 'enter your full name';
                      } else {
                        return null;
                      }
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: redButtonColor),
                        ),
                        icon: Padding(
                          padding: const EdgeInsets.only(top:10.0),
                          child: Icon(
                            Icons.person_outline,
                            color: Colors.black,
                            size: 40.0,
                          ),
                        ),
                        hintText: '',
                        labelText: 'FULL NAME',
                        labelStyle: TextStyle(
                          color: redButtonColor,
                          fontSize: 18.0,
                        )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 10.0, right: 30.0),
                child: Container(
                  child: TextFormField(
                    // validation for email field on form
                    validator: (value) {
                      if(value == '') {
                        return 'enter an email';
                      } else {
                        setState(() {
                          userEmail = value;
                        });
                        return null;
                      }
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: redButtonColor),
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
                          color: redButtonColor,
                          fontSize: 18.0,
                        )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 10.0, right: 30.0),
                child: Container(
                  child: TextFormField(
                    // validation for password field on form
                    validator: (value) {
                      if(value == '') {
                        return 'invalid password';
                      } else {
                        setState(() {
                          userPassword = value;
                        });
                        return null;
                      }
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: redButtonColor),
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
                          color: redButtonColor,
                          fontSize: 18.0,
                        )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 10.0, right: 30.0),
                child: Container(
                  child: TextFormField(
                    // validation for confirm password field on form
                    validator: (value) {
                      if(value == "" || value != userPassword) {
                        return 'passwords do not match';
                      } else {
                        return null;
                      }
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: redButtonColor),
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
                        labelText: 'CONFIRM PASSWORD',
                        labelStyle: TextStyle(
                          color: redButtonColor,
                          fontSize: 18.0,
                        )
                    ),
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 100.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RoundedButton(
                        title: 'REGISTER',
                        buttonTextColor: Colors.white,
                        buttonColor: redButtonColor,
                        onPressed: () async {
                          // if the user input is valid then we take the user to the home_screen
                          if(formKey.currentState.validate()) {
                            // TODO: add try catch for registration or internet errors
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