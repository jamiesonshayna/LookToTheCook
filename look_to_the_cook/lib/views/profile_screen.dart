import 'package:flutter/material.dart';
import 'package:look_to_the_cook/views/landing_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:look_to_the_cook/classes/delete_account_class.dart';
import 'package:look_to_the_cook/classes/reset_password_class.dart';
import 'package:look_to_the_cook/classes/regex_helper_class.dart';

// TEMPLATE COMPONENTS:
import 'package:look_to_the_cook/templates/app_bar_component.dart';
import 'package:look_to_the_cook/templates/normal_text.dart';
import 'package:look_to_the_cook/templates/constants.dart';
import 'package:look_to_the_cook/templates/rounded_button.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 01/30/2020
Last Modified: 02/27/2020
File Name: profile_screen.dart
Version: 3.0
Description: The purpose of this file is to build and render the user profile screen.
This screen will display the user profile information such as username, email, and any
set preferences. On this screen the user will be able to choose to reset a password, or
cancel/delete their account.
 */
class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';

  final String userName;
  final String userEmail;
  final userPassword;

  ProfileScreen({@required this.userName, @required this.userEmail,
    @required this.userPassword});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // to validate the new password field (user input)
  final formKey = GlobalKey<FormState>();

  // keep track of user's new password for reset
  String newPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBarComponent(
          title: '',
          leftIcon: Icon(Icons.arrow_back_ios),
          invisibleRightIcon: true,
          leftOnPressed: () {
            Navigator.pop(context); // go back to settings_screen
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
          children: <Widget>[
            Container(
              color: kRedButtonColor,
              height: 150.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: NormalText(
                      text: widget.userName,
                      textSize: 35.0,
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                  child: NormalText(
                    text: 'Email',
                    textColor: Colors.black,
                    textSize: 25.0,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0, bottom: 50.0),
                  child: NormalText(
                    text: widget.userEmail,
                    textColor: Colors.black,
                    textSize: 15.0,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
                  child: NormalText(
                    text: 'Profile Type',
                    textColor: Colors.black,
                    textSize: 25.0,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0, bottom: 50.0),
                  child: NormalText(
                    text: 'Active membership',
                    textColor: Colors.black,
                    textSize: 15.0,
                  ),
                ),
              ],
            ),

            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RoundedButton(
                      title: 'RESET PASSWORD',
                      buttonTextColor: Colors.white,
                      buttonColor: kRedButtonColor,
                      onPressed: () {
                        Alert(
                            style: AlertStyle(
                              isOverlayTapDismiss: false, // forces the user to verify
                            ),
                            context: context,
                            title: "ENTER NEW PASSWORD",
                            content: Form(
                              key: formKey,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: TextFormField(
                                      validator: (value) {
                                        RegexHelperClass regexHelper = new RegexHelperClass();

                                        if(value.trim() == '' || regexHelper.validatePassword(value) == false) {
                                          return 'invalid password';
                                        } else if(value == widget.userPassword) {
                                          return 'must be a new password';
                                        } else {
                                          setState(() {
                                            newPassword = value;
                                          });
                                          return null;
                                        }
                                      },
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: kRedButtonColor)
                                        ),
                                        hintText: 'password',
                                        icon: Icon(Icons.lock, color: kRedButtonColor,),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            buttons: [
                              DialogButton(
                                onPressed: () async {
                                  if(formKey.currentState.validate()) {
                                    // attempt to reset password if new password is valid
                                    ResetPassword resetPw = new ResetPassword();
                                    if(await resetPw.resetUserPassword(newPassword)) {
                                      Navigator.pop(context);
                                    } // else -> THIS SHOULDN'T HAPPEN
                                  }
                                },
                                child: Text(
                                  "RESET",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                color: Colors.black,
                              )
                            ]).show();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 40.0),
              child: GestureDetector(
                onTap: () {
                  Alert(
                    style: AlertStyle(
                      isCloseButton: false, // forces the user to verify
                      isOverlayTapDismiss: false, // forces the user to verify
                    ),
                    context: context,
                    title: "Are you sure? We\'re sad to see you go.",
                    desc: "",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "NO",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        width: 120,
                        color: Colors.black,
                      ),
                      DialogButton(
                        child: Text(
                          "YES",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () async {
                          // logic to delete account
                          DeleteAccount deleteAccount = new DeleteAccount();

                          if(await deleteAccount.deleteUserAccount() == true) {
                          Navigator.pushNamed(context, LandingScreen.id);
                          } // else ->  this SHOULD NOT happen (internet error?)
                        },
                        width: 120,
                        color: Colors.black,
                      ),
                    ],
                  ).show();
                },
                child: NormalText(
                  text: 'Permanently Delete Account',
                  textColor: Colors.red,
                  textSize: 15.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
