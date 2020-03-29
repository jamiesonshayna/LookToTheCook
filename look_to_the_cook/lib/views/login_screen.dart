import 'package:flutter/material.dart';
import 'package:look_to_the_cook/classes/login_logout_class.dart';
import 'package:look_to_the_cook/classes/regex_helper_class.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:look_to_the_cook/classes/internet_checker_class.dart';
import 'dart:async';

// TEMPLATE COMPONENTS:
import 'package:look_to_the_cook/templates/app_bar_component.dart';
import'package:look_to_the_cook/templates/constants.dart';
import 'package:look_to_the_cook/templates/rounded_button.dart';

// ROUTES:
import 'package:look_to_the_cook/views/home_screen.dart';
import 'package:look_to_the_cook/views/landing_screen.dart';
import 'package:look_to_the_cook/views/forgot_password_screen.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 02/01/2020
Last Modified: 03/02/2020
File Name: login_screen.dart
Version: 4.0
Description: The purpose of this file is to allow currently registered users to log into
their Look To The Cook accounts. Users will use the email and password that they signed up
with to let the app communicate with AWS and start a valid session. Regex is used again to
validate user input before attempting a proper login. If the user's credentials come back
and don't work then we provide error handling and a message that allows the user to go to
a forgot_password_screen view to set a new password with AWS.
 */
class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // listener for the text field user input that allow us to capture user data
  final formKey = GlobalKey<FormState>();

  // to keep track of the loading spinner
  bool _isLoggingIn = false;

  // regex helper object for validation
  RegexHelperClass regexHelper = new RegexHelperClass();
  LoginLogout loginHelper = new LoginLogout();

  // user attributes for login
  String email = "";
  String password = "";

  // error catching and handling from login
  bool invalidLogin = false;

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
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125.0),
        child: AppBarComponent(
          title: 'LOG IN',
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
                  padding: const EdgeInsets.only(top: 100.0, left: 10.0, right: 30.0),
                  child: Container(
                    child: TextFormField(
                      // validation for email field on login form
                      validator: (value) {
                        if(regexHelper.validateEmail(value.trim()) == false) {
                          return 'invalid email';
                        } else {
                          setState(() {
                            email = value;
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
                  padding: const EdgeInsets.only(top: 40.0, left: 10.0, right: 30.0),
                  child: Container(
                    child: TextFormField(
                      obscureText: true,
                      // validation for password field on login form
                      validator: (value) {
                        if(regexHelper.validatePassword(value) == false) {
                          return 'invalid password';
                        } else {
                          setState(() {
                            password = value;
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
                Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RoundedButton(
                          title: 'LOG IN',
                          buttonTextColor: Colors.white,
                          buttonColor: kRedButtonColor,
                          onPressed: () async {
                            // instantiate new internet checking object
                            InternetCheckerClass internetHelper = new InternetCheckerClass();
                            if(await internetHelper.hasConnection() == true) {
                              // if the user input is valid then we start AWS login
                              if(formKey.currentState.validate()) {
                                setState(() { // start loading spinner
                                  _isLoggingIn = true;
                                });

                                // let loading spinner go
                                await new Future.delayed(const Duration(seconds: 1));

                                if(await loginHelper.manualAuthenticateAndLogin(email, password)) {
                                  setState(() {
                                    _isLoggingIn = false;
                                  });
                                  // have authenticated and set credentials (can log in)
                                  Navigator.pushNamed(context, HomeScreen.id);
                                } else {
                                  setState(() {
                                    _isLoggingIn = false;
                                    invalidLogin = true;
                                  });
                                }
                              }
                            }
                            // else there is no internet and display alert
                            else {
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
                  padding: const EdgeInsets.only(bottom: 100.0, top: 15.0, left: 15.0, right: 15.0),
                  child: invalidLogin == false ? SizedBox() :
                  SizedBox(
                      child: loginHelper.getErrorNotConfirmed() == false ?
                      new GestureDetector(
                        onTap:() {
                          Navigator.pushNamed(context, ForgotPasswordScreen.id);
                        }, child:
                      Text.rich(
                        TextSpan(
                          text: 'Invalid email or password.  ',
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Forgot Password?',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                )),
                            // can add more TextSpans here...
                          ],
                        ),
                      )) :
                      GestureDetector(
                        onTap: () async {
                          // allow user to send email to 'customer service'
                          await _launchEmail();
                        },
                        child: Text.rich(
                          TextSpan(
                          text: 'Account has not been authenticated. Please contact: ',
                          children: <TextSpan>[
                          TextSpan(
                            text: 'info.looktothecook@gmail.com',
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.blue,
                                decoration: TextDecoration.underline
                            ),
                          ),
                          ]),
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
        inAsyncCall: _isLoggingIn,
        dismissible: false,
        progressIndicator: SpinKitWave(
          color: kRedButtonColor,
        ),
      ),
    );
  }
}