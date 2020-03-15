/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 02/19/2020
Last Modified: 02/19/2020
File Name: regex_helper_class.dart
Version: 1.0
Description: This file allows for quicker registration, login, reset pw, etc. validation. Here we are
able to use our RegexHelper object in order to validate a password or email.
 */
class RegexHelperClass {

  /*
  This method checks to make sure that user passwords are compliant with AWS.

  User passwords must be at least a length of 8, have uppercase and lowercase
  letters, as well as at least one number.
  @param The user password that we need to check.
  @return True if the password is valid, false otherwise.
   */
  bool validatePassword(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    return RegExp(pattern).hasMatch(value);
  }

  /*
  This method checks to make sure that user emails are compliant with AWS.

  User emails must contain the @ symbol, have characters before and after the
  @, as well as a .something.
  @param The user email that we need to check.
  @return True if the email is valid, false otherwise.
   */
  bool validateEmail(String value) {
    Pattern pattern = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";

    return RegExp(pattern).hasMatch(value);
  }
}