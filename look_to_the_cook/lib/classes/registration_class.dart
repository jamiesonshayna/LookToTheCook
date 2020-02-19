import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:look_to_the_cook/classes/secure_storage_class.dart';

/*
POOL NAME: LookToTheCookUsers
APP CLIENT NAME: LookToTheCookClient
APP CLIENT ID: 1hhicps9mo7ukqgqkvq9nnp36n
USER POOL ID: us-west-2_dscLXwSqb

 */

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 02/19/2020
Last Modified: 02/19/2020
File Name: registration_class.dart
Version: 1.0
Description: This.......
 */
class Registration {
  // private fields
  CognitoUserPool _userPool = new CognitoUserPool("us-west-2_dscLXwSqb", "23nvu4t7pejbifgb6jndgvula9");
  SecureStorage _storage = new SecureStorage();
  //String error = "";

  /*
  This method attempts to register a new user in AWS with the name attribute
  and email and password for verification.

  @param name The user's name
  @param email The user's email
  @param password The user's password
   */
  Future<bool> registerUser(String name, String email, String password) async {
    // create user attributes object for AWS compliance
    final userAttributes = [
      new AttributeArg(name: 'name', value: name),
    ];

    // attempt registration
    var data;
    try {
      data = await _userPool.signUp(email, password,
          userAttributes: userAttributes);

      // if true then we want to set our secure storage for email, password, and name
      // we need to wait for these to finish so that we can use in other methods (await)
      await _storage.writeToStorage("email", email);
      await _storage.writeToStorage("password", password);
      await _storage.writeToStorage("name", name);

      return true;
    } catch (e) {
      print(e);
      // TODO: Set error string so that we can return
      return false;
    }
  }

  /*
  This method takes a registered user's credentials and confirms the account via AWS
  with a code that gets sent to the user's registered email (secure storage).

  @param code The code that got sent to the user's email.
  @return True if confirmed, false otherwise.
   */
  Future<bool> confirmRegistration(String code) async {
    // create cognito user object - used for AWS functionality
    final cognitoUser = new CognitoUser(
        await _storage.readFromStorage("email"), _userPool);

    bool registrationConfirmed = false;
    try {
      registrationConfirmed = await cognitoUser.confirmRegistration(code);
      return registrationConfirmed;
    } catch (e) {
      print(e);
      return registrationConfirmed;
    }
  }

  /*
  This method re-sends the registration confirmation code if the user didn't get it.
   */
  resendVerificationCode() async {
    // create cognito user object - used for AWS functionality
    final cognitoUser = new CognitoUser(
        await _storage.readFromStorage("email"), _userPool);

    String status;
    try {
      status = await cognitoUser.resendConfirmationCode();
    } catch (e) {
      print(e);
    }
  }


  Future<bool> authenticateAndLogin() async {
    // create cognito user object - used for AWS functionality
    final cognitoUser = new CognitoUser(
        await _storage.readFromStorage("email"), _userPool);

    final authDetails = new AuthenticationDetails(
        username: await _storage.readFromStorage("email"), password: await _storage.readFromStorage("password"));

    CognitoUserSession session;

    try {
      session = await cognitoUser.authenticateUser(authDetails);
      print(session.getAccessToken().getJwtToken()); // for debug
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}