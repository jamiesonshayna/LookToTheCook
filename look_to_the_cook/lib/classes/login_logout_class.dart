import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:look_to_the_cook/classes/secure_storage_class.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 02/19/2020
Last Modified: 02/19/2020
File Name: login_logout_class.dart
Version: 1.0
Description: This class handles the logic behind authentication with AWS. It is used on the
login_screen.dart view. This class connects to the AWS user pool and client. Here we
can use those along with the client provided credentials to register a user, confirm/verify
their account, and then send success messages back to the view.
 */
class LoginLogout {
  // private fields
  CognitoUserPool _userPool = new CognitoUserPool("us-west-2_dscLXwSqb", "23nvu4t7pejbifgb6jndgvula9");
  SecureStorage _storage = new SecureStorage();

  bool _userNotConfirmed = false;

  /*
  This method creates a session for the user that has just been registered and confirmed.
  If we return true the user is taken to the home page with valid credentials.

  @return True if we have a valid AWS session, false otherwise.
   */
  Future<bool> autoAuthenticateAndLogin() async {
    // create cognito user object - used for AWS functionality
    final cognitoUser = new CognitoUser(
        await _storage.readFromStorage("email"), _userPool);

    final authDetails = new AuthenticationDetails(
        username: await _storage.readFromStorage("email"), password: await _storage.readFromStorage("password"));

    CognitoUserSession session;

    try {
      session = await cognitoUser.authenticateUser(authDetails);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /*
  This method is used when manually logging in for a user that has logged out already.
  Here we take their inputted email and password and attempt to create a valid
  session for the user. On valid session we set secure credentials in the phone so that
  the next time the user can auto-login.

  @param email The user's email.
  @param password The user's password.
  @return True if we have a valid AWS session, false otherwise.
   */
  Future<bool> manualAuthenticateAndLogin(String email, String password) async {
    // create cognito user object - used for AWS functionality
    final cognitoUser = new CognitoUser(email, _userPool);

    final authDetails = new AuthenticationDetails(
        username: email, password: password);

    CognitoUserSession session;

    try {
      session = await cognitoUser.authenticateUser(authDetails);

      // set secure storage credentials when logging in
      await getAndSetAttributes(cognitoUser, email, password);
      return true;
    } catch (e) {
      if(e.name == 'UserNotConfirmedException') {
        _userNotConfirmed = true;
      } else {
        _userNotConfirmed = false;
      }
      print(e);
      return false;
    }
  }

  /*
  This method sets the user's credentials to secure storage locally. This is so that we
  can display their name on the home page, write to database with unique email, reset passwords,
  etc. (anything related to AWS profiles or database communication)

  @param cognitoUser The current AWS session user.
  @param email The user's email.
  @param password The user's password.
   */
  getAndSetAttributes(CognitoUser cognitoUser, String email, String password) async {
    await _storage.writeToStorage("email", email);
    await _storage.writeToStorage("password", password);

    List<CognitoUserAttribute> attributes;

    try {
      attributes = await cognitoUser.getUserAttributes();

      attributes.forEach((attribute) async {
        if(attribute.getName().toString() == "name") {
          String name = attribute.getValue().toString();
          await _storage.writeToStorage("name", name);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  /* ********************** LOGOUT ************************ */

  Future<bool> logout() async {
    // create cognito user object - used for AWS functionality
    final cognitoUser = new CognitoUser(
        await _storage.readFromStorage("email"), _userPool);

    final authDetails = new AuthenticationDetails(
        username: await _storage.readFromStorage("email"), password: await _storage.readFromStorage("password"));

    CognitoUserSession session;

    try {
      session = await cognitoUser.authenticateUser(authDetails);

      // sign-out and clear credentials
      await cognitoUser.signOut();
      _storage.writeToStorage("email", "");
      _storage.writeToStorage("password", "");
      _storage.writeToStorage("name", "");

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /*
  This method returns the status of the login user.

  @return bool is the user unconfirmed
   */
  bool getErrorNotConfirmed() {
    return _userNotConfirmed;
  }
}