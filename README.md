# :pizza: :hamburger: :doughnut: LookToTheCook :doughnut: :hamburger: :pizza:
A kitchen aid. Providing end-users with item quantity tracking, shopping list
export, and user alerts. This app will welcome users with bright pops of color, fun animations,
and superior UX. To access their profile, users will need to register/login to the application. From
here, they are able to access profile settings, about us content, and how tos. On the main
screen (home screen) users will have the option to view their current kitchen inventory (where
they can add/remove new items, track quantity levels, and set alerts), or view their shopping list
(which contains an archive of deleted/purchased items, current low-quantity items, as well as
the option to add/delete items in the list.

# MVC Requirement Explanation
- <b>M: look_to_the_cook -> lib -> Models -> services.dart</b> <br>
> To handle business login in our application we had to store code in multiple places. Currently there are not many good packages for Flutter that allow direct communication from the app to a MySql database. The route that we took was first having the services.dart file in our immediate code. This file determines which type of query is to be run on the remote database and then packages that data. After that, the file communicates with LookDB.php which is a file on the remote server (can be found on GitHub (top-level in repo)). LookDB.php handles the actual query with the information that was sent from services.dart and makes the connection to the remote database. Data coming back as a response follows the same flow but in reverse. All database logic happens in these two files. In the future, Rob and I would like to build out our database functionality to work when the app is not able to connect to the internet. To do this we will implement a Sqlite database that is linked to a user’s particular device. The app would check at various points whether or not an internet connection had been re-established, and if so, it would sync up the data from the local database to the remote.

- <b>V: look_to_the_cook -> lib -> views/</b> <br>
> Our view UIs are all located within the views folder. The views allow us to display relevant user data, and for the user to request to modify (update, delete, add) data as well. The two types of views that we have are stateful and stateless. The stateless UI views are going to be those that are static. Most of the screens are stateful because we are changing the elements on screen to respond to user interaction. Views are built with connected widgets and drawn onto the screen upon rendering. Many views contain templated components i.e. a rounded button to allow for code re-use, simplification, and standardization.

- <b>C: look_to_the_cook -> lib -> main.dart</b> <br>
> Being that Flutter is different than Fat-Free we tried to relate our code to class requirements as best as we could. The main.dart file acts as a piece of our controller. In that file we create all of our app-wide routes that can be accessed from any of our views. This file also acts as a place to set app-wide settings i.e. device orientation, fonts, color schemes etc. The main.dart file is called when the user interacts with a view and wants to transition to a different screen and renders the appropriate view with the code provided on each view widget. You could also consider most of our classes (look_to_the_cook -> lib -> classes/) as controllers. When a user clicks on a button (for example), usually the app will communicate to the relevant class with the user inputted data (i.e. credentials, inventory items). The class will package the data and then communicate with either Amazon Web Services (Cognito for Authentication) or our PHP database layer that is hosted on our server. The class will communicate the response from the model to the view and allow the view to render accordingly.

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
