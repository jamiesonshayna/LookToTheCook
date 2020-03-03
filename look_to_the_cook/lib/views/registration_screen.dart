import 'package:flutter/material.dart';
import 'package:look_to_the_cook/classes/regex_helper_class.dart';
import 'package:look_to_the_cook/classes/registration_class.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

// TEMPLATE COMPONENTS:
import 'package:look_to_the_cook/templates/rounded_button.dart';
import 'package:look_to_the_cook/templates/app_bar_component.dart';
import 'package:look_to_the_cook/templates/constants.dart';

// ROUTES:
import 'package:look_to_the_cook/views/home_screen.dart';
import 'package:look_to_the_cook/views/login_screen.dart';
import 'package:look_to_the_cook/views/landing_screen.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 01/30/2020
Last Modified: 03/02/2020
File Name: registration_screen.dart
Version: 4.0
Description: The purpose of this file is to build and render the registration screen and allow
for new user sign up. Registration is done through AWS with Cognito. This class relies heavily
on the classes: Registration(). This class provides the AWS connection with private variables,
as well as the actual functionality to register, confirm, and then authenticate. The user is taken
step by step through the process and if their account already exists we display an error and take
the user to the login page.
 */


class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // disposing of row listeners after navigating away or closing screen
  // so as not to keep them running in the background
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }
  // listener for the text field user input that allow us to capture user data
  final formKey = GlobalKey<FormState>();
  // listener for text and input fields
  TextEditingController _textFieldController = TextEditingController();

  // variable to keep track of loading spinner
  bool _isRegistering = false;

  // objects used throughout form validation and registration
  RegexHelperClass regexHelper = new RegexHelperClass();
  Registration registerHelper = new Registration();

  // used to store user credentials for AWS registration
  String userEmail = '';
  String userPassword = '';
  String userName = '';

  // registration code and error handling
  String code;
  bool alreadyHasAccount = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125.0),
        child: AppBarComponent(
          title: 'REGISTER',
          leftIcon: Icon(Icons.arrow_back_ios),
          invisibleRightIcon: true,
          leftOnPressed: () {
            Navigator.pushNamed(context, LandingScreen.id); // go back to landing_screen
          },
        ),
      ),
      body: ModalProgressHUD(
        child: GestureDetector(
          onTap: () {
            // lets the user exit text field by tapping background scaffold
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 10.0, right: 30.0),
                  child: Container(
                    child: TextFormField(
                      // validation for name field on login form
                      validator: (value) {
                        if(value.trim() == '') {
                          return 'enter a name';
                        } else {
                          setState(() {
                            userName = value;
                          });
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
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Icon(
                              Icons.person_outline,
                              color: Colors.black,
                              size: 40.0,
                            ),
                          ),
                          hintText: '',
                          labelText: 'FULL NAME',
                          labelStyle: TextStyle(
                            color: kRedButtonColor,
                            fontSize: 18.0,
                          )
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 10.0, right: 30.0),
                  child: Container(
                    child: TextFormField(
                      // validation for email field on form
                      validator: (value) {
                        value = value.trim();
                        if(regexHelper.validateEmail(value) == false) {
                          return 'invalid email';
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
                  padding: const EdgeInsets.only(top: 25.0, left: 10.0, right: 30.0),
                  child: Container(
                    child: TextFormField(
                      obscureText: true,
                      // validation for password field on form
                      validator: (value) {
                        if(regexHelper.validatePassword(value) == false) {
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
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 10.0, right: 30.0),
                  child: Container(
                    child: TextFormField(
                      obscureText: true,
                      // validation for confirm password field on form
                      validator: (value) {
                        if(value.trim() == '' || value != userPassword) {
                          if(value.trim() == '' && userPassword == '') {
                            return 'invalid password';
                          } else {
                            return 'passwords do not match';
                          }
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
                          labelText: 'CONFIRM PASSWORD',
                          labelStyle: TextStyle(
                            color: kRedButtonColor,
                            fontSize: 18.0,
                          )
                      ),
                    ),
                  ),
                ),
                Expanded(child: SizedBox(),),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RoundedButton(
                          title: 'REGISTER',
                          buttonTextColor: Colors.white,
                          buttonColor: kRedButtonColor,
                          onPressed: () async {
                            // if the user input is valid then we start AWS registration
                            if(formKey.currentState.validate()) {
                              // call first registration method
                              if(await registerHelper.registerUser(userName, userEmail, userPassword)) {
                                // now we need to start the popup for code verification
                                Alert(
                                    style: AlertStyle(
                                      isCloseButton: false, // forces the user to verify
                                      isOverlayTapDismiss: false, // forces the user to verify
                                    ),
                                    context: context,
                                    content: Center(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        controller:
                                        _textFieldController,
                                        decoration: InputDecoration(
                                            hintText:
                                            'please enter code'),
                                      ),
                                    ),
                                    title: 'VERIFY EMAIL',
                                    desc:
                                    'To verify your account please check your email for code and enter below.',
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          'RESEND CODE',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                        onPressed: () async {
                                          try {
                                            // uses AWS procedures to resend verification code if user didn't get one
                                            await registerHelper.resendVerificationCode();

                                            setState(() { // reset the code input area so user can try again
                                              _textFieldController.text = '';
                                            });
                                          } catch(e) {
                                            print(e);
                                          }
                                        },
                                        color: kRedButtonColor,
                                      ),
                                      DialogButton(
                                        child: Text(
                                          'CONFIRM',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                        onPressed: () async {
                                          // get the value from the popup form
                                          setState(() {
                                            if (_textFieldController
                                                .text !=
                                                '' ||
                                                _textFieldController
                                                    .text !=
                                                    null) {
                                              code =
                                                  _textFieldController
                                                      .text;
                                            }
                                          });

                                          // we need to try to use the code to confirm registration
                                          bool hasConfirmed = await registerHelper.confirmRegistration(code);

                                          // this means that registration and confirmation were successful
                                          if (hasConfirmed) {
                                            // authenticate user and move to the login screen on success
                                            if(await registerHelper.authenticateAndLogin()) {
                                              setState(() {
                                                // pop context of pop-up code confirm
                                                Navigator.pop(context);
                                              });

                                              setState(() { // start loading spinner
                                                _isRegistering = true;
                                              });

                                              // let loading spinner go
                                              await new Future.delayed(const Duration(seconds: 2));

                                              setState(() {
                                                _isRegistering = false;

                                                // take user the the home screen
                                                Navigator.pushNamed(context, HomeScreen.id);
                                              });
                                            }  // else nothing should happen
                                          }
                                          // we were not able to register the user with their given code
                                          // they must try again here
                                          else {
                                            setState(() {
                                              // display code error text
                                              _textFieldController.text = 'invalid code';
                                            });
                                            // pause to show error
                                            await new Future.delayed(const Duration(seconds : 1));

                                            // reset code section so user can re-enter their code
                                            setState(() {
                                              _textFieldController.text = '';
                                            });
                                          }
                                        },
                                        width: 120,
                                        color: kRedButtonColor,
                                      ),
                                    ]).show();

                              } else {
                                setState(() {
                                  alreadyHasAccount = true;
                                });
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0, top: 10.0),
                  child: SizedBox(
                    child:
                      alreadyHasAccount == false ? Text('') : new GestureDetector(
                          onTap:() {
                            Navigator.pushNamed(context, LoginScreen.id);
                          }, child: Text.rich(
                        TextSpan(
                          text: 'Account already exists.  ',
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Log in?',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                )),
                            // can add more TextSpans here...
                          ],
                        ),
                      ),)
                  ),
                ),
              ],
            ),
          ),
        ),
        inAsyncCall: _isRegistering,
        dismissible: false,
        progressIndicator: SpinKitWave(
          color: kRedButtonColor,
        ),
      ),
    );
  }
}