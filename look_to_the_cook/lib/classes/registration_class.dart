import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:look_to_the_cook/classes/secure_storage_class.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 02/19/2020
Last Modified: 02/19/2020
File Name: registration_class.dart
Version: 1.0
Description: This class handles the logic behind authentication with AWS. It is used on the
registration_screen.dart view. This class connects to the AWS user pool and client. Here we
can use those along with the client provided credentials to register a user, confirm/verify
their account, and then send success messages back to the view.
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

  /*
  This method creates a session for the user that has just been registered and confirmed.
  If we return true the user is taken to the home page with valid credentials.

  @return True if we have a valid AWS session, false otherwise.
   */
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