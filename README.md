# :pizza: :hamburger: :doughnut: LookToTheCook :doughnut: :hamburger: :pizza:
Kitchen Aid- to track item quantities, export shopping lists, generate recipes, and provide user alerts.

# Authors
Shayna Jamieson - GitHub: <https://www.github.com/jamiesonshayna> <br>
Rob Wood - GitHub: <https://github.com/woodrdk>

# Getting Started 
To get this program up and running on your own local machine you will need a few things:

<details>
  <summary><strong>Prerequisites</strong></summary>
  
:small_orange_diamond: Windows:
> Operating Systems: Windows 7 SP1 or later (64-bit) <br>
> Disk Space: 400 MB (does not include disk space for IDE/tools). <br>
> Tools: Flutter depends on these tools being available in your environment. <br>
> Windows PowerShell 5.0 or newer (this is pre-installed with Windows 10) <br>
> Git for Windows 2.x, with the Use Git from the Windows Command Prompt option. <br>
> If Git for Windows is already installed, make sure you can run git commands from the command prompt or PowerShell.

:small_orange_diamond: Mac:
> Operating Systems: macOS (64-bit) <br>
> Disk Space: 700 MB (does not include disk space for IDE/tools). <br>
> Tools: Flutter depends on these command-line tools being available in your environment.
bash, curl, git 2.x, mkdir, rm, unzip, which

:small_orange_diamond: Linux:
> Operating Systems: Linux (64-bit) <br>
> Disk Space: 600 MB (does not include disk space for IDE/tools). <br>
> Tools: Flutter depends on these command-line tools being available in your environment.
bash, curl, git 2.x, mkdir, rm, unzip, which, xz-utils <br>
> Shared libraries: Flutter test command depends on this library being available in your environment.
libGLU.so.1 - provided by mesa packages such as libglu1-mesa on Ubuntu/Debian

  </details>
  
  <details>
    <summary><strong>Installation</strong></summary>
  
:small_orange_diamond: Step 1:
> Naviagte to https://flutter.dev/docs/get-started/install
this takes you to Flutter's installation page. From here select which type of operating system  you would like to install on.
  
:small_orange_diamond: Step 2:
> Depending on which operating system you have chosen you will be directed to the correct Flutter installation page. Start at the top of the page and follow all set-up instructions (if you are using a mac you will also need to download XCode - instructions provided). On this page you will also be setting up your iOS simulator (by-product of XCode), Android Emulator (through Android Studios), and getting flutter completely set up on your local machine.

> Windows: https://flutter.dev/docs/get-started/install/windows <br>
> Linux: https://flutter.dev/docs/get-started/install/linux <br>
> Mac: https://flutter.dev/docs/get-started/install/macos

:small_orange_diamond: Step 3:
> After installing the Flutter SDK users can normally choose between using Visual Studio Code as an editor or Android Studios/IntelliJ. This project is done and set up with Android Studios. To install Android Studio, flutter.dev has provided more information https://flutter.dev/docs/get-started/editor. Here you will be taken through steps to setup Android Studio. Once that has been installed, on the same page there are instructions on how to install the Flutter and Dart plugins that are needed for this project.

:small_orange_diamond: Step 4:
> If you would like to confirm successful implementation of steps 1-3 navigate to https://flutter.dev/docs/get-started/test-drive, for a full list of steps on testing a basic application.

:small_orange_diamond: Step 5:
> To get started working on this repo on your personal machine after successful installation of all needed tools- navigate to the directory you would like to put the application and paste the following code into your terminal/bash.

```console
foo@bar:~$ git clone https://github.com/jamiesonshayna/LookToTheCook.git
```

</details>

# Running Tests
V1 Look To The Cook is being tested manually. 
(When unit tests are added, update this section)

# Built With
- Flutter SDK
- Dart, PHP
- Android Studios IDE
- XCode with iOS Simulator
- Amazon Web Services (Cognito User Pool - Authentication)
- PhpMyAdmin (MySql Database)
- Terminal (Homebrew, Zsh)

# Plugins
This application draws on resources of several packages/plugins. These plugins are responsible for capabilities such as AWS connectivity, loading spinners, secure storage, etc. To add or view these plugins you can navigate to:

- In-App: LookToTheCook -> look_to_the_cook -> pubspec.yaml
- GitHub: https://github.com/jamiesonshayna/LookToTheCook/blob/master/look_to_the_cook/pubspec.yaml


# Amazon Web Services - User Authentication
This is the necessary information needed to maintain AWS authentication.

<details>
  <summary>Credentials</summary>
  
  - if you make a new user pool these lines need to be updated in the code base. Files to update are included below.
  
  ```dart
  // USER POOL ID
  final String userPoolID = 'XX-XXXX-XXXXXXXXXXX';
  // CLIENT ID
  final String clientID = 'XXXXXXXXXXXXXXXXXXXX';
  ```

  </details>
  
<details>
  <summary>Files to Update</summary>
  
  - file path: LookToTheCook -> look_to_the_cook -> lib -> classes
  
    - delete_account_class.dart
    - login_logout_class.dart
    - registration_class.dart
    - reset_password_class.dart
    - forgot_password_class.dart
  
  </details>

<details>
  <summary>How to Create New User Pool</summary>
  
  - To make a new user pool you should use the step-by-step setup wizard on AWS. There are a few things to keep in mind that
  are required for the V1 application to authenticate successfully.
  
    - Attributes: choose allow email addresses, only require name
    - Policies (require): minimum length 8, uppercase characters, lowercase letters, and at least one number
    - MFA Verification: choose verify with email
    - Message Customization: choose cognito default
    - App Client: make sure you set an app client (this is used above for the code base as 'clientID').
  
  </details>
  
  # cPanel - Remote MySQL Database

This is the necessary information needed to create and maintain the application's remote database.
