import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:look_to_the_cook/classes/secure_storage_class.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 02/27/2020
Last Modified: 02/27/2020
File Name: forgot_password_class.dart
Version: 1.0
Description: This class handles the logic behind forgot password flow with AWS. It is used on the
forgot_password_screen.dart view. This class connects to the AWS user pool and client. Here we
can use those along with the client provided credentials to send an email to be verified to the user
and then set a new password along with that code and log the user in.
 */
class ForgotPassword {
  // private fields
  CognitoUserPool _userPool = new CognitoUserPool("us-west-2_dscLXwSqb", "23nvu4t7pejbifgb6jndgvula9");
  SecureStorage _storage = new SecureStorage();
  CognitoUser _cognitoUser;

  /*
  This method will setup forgot password flow for registered users.

  We first start a valid user session. After validating the session we
  send the verification code to the user's registered email.
  @return Future<bool> true if success, false otherwise
   */
  Future<bool> forgotUserPassword() async {
    // create cognito user object - used for AWS functionality
    final cognitoUser = new CognitoUser(
        await _storage.readFromStorage("email"), _userPool);

    final authDetails = new AuthenticationDetails(
        username: await _storage.readFromStorage("email"), password: await _storage.readFromStorage("password"));

    CognitoUserSession session;
    var data;

    // send user forgot password code to registered email
    try {
      session = await cognitoUser.authenticateUser(authDetails);
      data = await cognitoUser.forgotPassword();
      _cognitoUser = cognitoUser;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /*
  This method will finish forgot password flow for registered users.

  We take the code for forgot password as well as the new valid password and
  combine the two to reset password with AWS. If that is a success we reset the
  user's local persistent data as well.
  @return Future<bool> true if success, false otherwise
   */
  Future<bool> resetWithCode(String code, String password) async {
    bool passwordConfirmed = false;

    try {
      passwordConfirmed = await _cognitoUser.confirmPassword(code, password);
      await _storage.writeToStorage('password', password);
      return passwordConfirmed;
    } catch(e) {
      print(e);
      return false;
    }
  }
}