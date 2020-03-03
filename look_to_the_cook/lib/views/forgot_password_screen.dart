import 'package:flutter/material.dart';
import 'package:look_to_the_cook/classes/forgot_password_class.dart';
import 'package:look_to_the_cook/classes/regex_helper_class.dart';

// TEMPLATES:
import 'package:look_to_the_cook/templates/constants.dart';
import 'package:look_to_the_cook/templates/app_bar_component.dart';
import 'package:look_to_the_cook/templates/rounded_button.dart';

// ROUTES:
import 'package:look_to_the_cook/views/home_screen.dart';
import 'package:look_to_the_cook/views/login_screen.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 02/27/2020
Last Modified: 02/27/2020
File Name: forgot_password_screen.dart
Version: 1.0
Description: The purpose of this file is to allow registered users to reset
a password. They can do this by entering their email that they used for registration,
where they will then get a code sent to their email that they can use in combination with
a new email to reset credentials and login successfully.
 */
class ForgotPasswordScreen extends StatefulWidget {
  static const String id = 'forgot_password_screen';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // attributes to keep track of for resetting user's password and logging in
  String currentEmail;
  String newPassword;
  String userCode;

  // conditional values to change screen UI
  bool passwordChanged = false;
  bool hasSentEmail = false;
  bool codeIsWrong = false;

  // text form field listener (for validation)
  final formKey = GlobalKey<FormState>();
  // regex helper object
  RegexHelperClass regexHelper = new RegexHelperClass();
  // forgot password helper AWS class
  ForgotPassword passwordHelper = new ForgotPassword();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(125.0),
          child: AppBarComponent(
            title: 'RESET PASSWORD',
            leftIcon: Icon(Icons.arrow_back_ios),
            invisibleRightIcon: true,
            leftOnPressed: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
          ),
        ),
        body: new GestureDetector(
          onTap: () {
            // lets the user exit text field by tapping background scaffold
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Opacity(
                          opacity: hasSentEmail == false ? 1.0 : 0.0,
                          child: Container(
                            padding: EdgeInsets.only(top: 40.0, left: 10.0, right: 30.0),
                            child: TextFormField(
                              initialValue: '',
                              enabled: hasSentEmail == false ? true : false,
                              validator: (value) {
                                if(regexHelper.validateEmail(value) == false) {
                                  return 'invalid email';
                                } else {
                                  setState(() {
                                    currentEmail = value;
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
                                  labelText: 'CONFIRM USER EMAIL',
                                  labelStyle: TextStyle(
                                    color: kRedButtonColor,
                                    fontSize: 18.0,
                                  )
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Opacity(
                            opacity: hasSentEmail == false ? 0.0 : 1.0,
                            child: Container(
                              padding: EdgeInsets.only(left: 10.0, right: 30.0),
                              child: TextFormField(
                                enabled: hasSentEmail == false ? false : true,
                                validator: (value) {
                                  if(hasSentEmail == false) {
                                    return null;
                                  } else {
                                    if(value.trim() == '') {
                                      return 'enter the code from your email';
                                    } else {
                                      setState(() {
                                        userCode = value.trim();
                                      });
                                    }
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
                                        Icons.code,
                                        color: Colors.black,
                                        size: 40.0,
                                      ),
                                    ),
                                    hintText: '',
                                    labelText: 'EMAIL CODE',
                                    labelStyle: TextStyle(
                                      color: kRedButtonColor,
                                      fontSize: 18.0,
                                    )
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Opacity(
                            opacity: hasSentEmail == false ? 0.0 : 1.0,
                            child: Container(
                              padding: EdgeInsets.only(left: 10.0, right: 30.0),
                              child: TextFormField(
                                obscureText: true,
                                enabled: hasSentEmail == false ? false : true,
                                validator: (value) {
                                  if(hasSentEmail == false) {
                                    return null;
                                  } else {
                                    if(value.trim() == '') {
                                      return 'invalid password';
                                    } else {
                                      if(regexHelper.validatePassword(value) == false) {
                                        return 'invalid password';
                                      } else {
                                        setState(() {
                                          newPassword = value;
                                        });
                                        return null;
                                      }
                                    }
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
                                        Icons.lock,
                                        color: Colors.black,
                                        size: 40.0,
                                      ),
                                    ),
                                    hintText: '',
                                    labelText: 'NEW PASSWORD',
                                    labelStyle: TextStyle(
                                      color: kRedButtonColor,
                                      fontSize: 18.0,
                                    )
                                ),
                              ),
                            ),
                          ),
                        ),
                        Opacity(
                          opacity: hasSentEmail == false ? 0.0 : 1.0,
                          child: Container(
                            padding: EdgeInsets.only(left: 10.0, right: 30.0),
                            child: TextFormField(
                              obscureText: true,
                              enabled: hasSentEmail == false ? false : true,
                              validator: (value) {
                                if(hasSentEmail == false) {
                                  return null;
                                } else {
                                  if(value.trim() == '') {
                                    return 'invalid pasword';
                                  } else {
                                    if(value.trim() != newPassword) {
                                      return 'password do not match';
                                    } else {
                                      return null;
                                    }
                                  }
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
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 30.0),
                                  child: RoundedButton(
                                    buttonColor: kRedButtonColor,
                                    buttonTextColor: Colors.white,
                                    title: hasSentEmail == false ? 'SEND RESET CODE' : 'SUBMIT PASSWORD',
                                    onPressed: () async {
                                      // if the form is valid
                                      if(formKey.currentState.validate()) {
                                        // if we need to send the code
                                        if(hasSentEmail == false) {
                                          hasSentEmail = await passwordHelper.forgotUserPassword(currentEmail);

                                          if(hasSentEmail == true) {
                                            setState(() {
                                              hasSentEmail = true;
                                            });
                                          }
                                        } else {
                                          // we have code and need to try to reset and login
                                          passwordChanged = await passwordHelper.resetWithCode(userCode, newPassword, currentEmail);

                                          if(passwordChanged == false) {
                                            setState(() {
                                              codeIsWrong = true;
                                            });
                                          } else {
                                            // we have successfully changed the password and can login
                                            Navigator.pushNamed(context, HomeScreen.id);
                                          }
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
