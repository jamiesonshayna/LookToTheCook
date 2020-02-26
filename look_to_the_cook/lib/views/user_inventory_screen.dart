import 'package:flutter/material.dart';
import 'package:look_to_the_cook/Models/Services.dart';
import 'package:look_to_the_cook/classes/Inventory.dart';

// TEMPLATE COMPONENTS:
import 'package:look_to_the_cook/templates/app_bar_component.dart';

// ROUTES

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 01/30/2020
Last Modified: 02/04/2020
File Name: user_inventory_screen.dart
Version: 2.0
Description: The purpose of this file is to build and render the user inventory screen.
The screen.......... TODO: BUILD OUT THIS HEADER ONCE BUILT
 */

class UserInvScreen extends StatefulWidget{
  static const String id = 'userinv_screen';
  UserInvScreen() : super();
  final String title = "User Inventory Screen";

  @override
  UserInvScreenState createState() => UserInvScreenState();
}

class UserInvScreenState extends State<UserInvScreen>{
  List<Inventory> _inventory;
  GlobalKey<ScaffoldState> _scaffoldKey;
  // controller for the First Name TextField we are going to create.
  TextEditingController _whatController;
  // controller for the Last Name TextField we are going to create.
  TextEditingController _brandController;
  Inventory _selectedInventory;
  bool _isUpdating;
  String _titleProgress;

  @override
  void initState() {
    super.initState();
    _inventory = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _whatController = TextEditingController();
    _brandController = TextEditingController();
    _getInventory();
  }
  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }
  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
  _getInventory() {
    _showProgress('Loading Inventory...');
    Services.getInventory().then((inventories) {
      setState(() {
        _inventory = inventories;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${inventories.length}");
    });
  }
  // Method to clear TextField values
  _clearValues() {
    _whatController.text = '';
    _brandController.text = '';
  }

  _showValues(Inventory inventory) {
    _whatController.text = inventory.what;
    _brandController.text = inventory.brand;
  }// Let's create a DataTable and show the employee list in it.
  SingleChildScrollView _dataBody() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('ID'),
            ),
            DataColumn(
              label: Text('What'),
            ),
            DataColumn(
              label: Text('Brand'),
            ),
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text('DELETE'),
            )
          ],
          rows: _inventory
              .map(
                (inventory) => DataRow(cells: [
              DataCell(
                Text(inventory.inventoryId.toString()),
                // Add tap in the row and populate the
                // textfields with the corresponding values to update
                onTap: () {
                  _showValues(inventory);
                  // Set the Selected inventory to Update
                  _selectedInventory = inventory;
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
              DataCell(
                Text(
                  inventory.what.toUpperCase(),
                ),
                onTap: () {
                  _showValues(inventory);
                  // Set the Selected inventory to Update
                  _selectedInventory = inventory;
                  // Set flag updating to true to indicate in Update Mode
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
              DataCell(
                Text(
                  inventory.brand.toUpperCase(),
                ),
                onTap: () {
                  _showValues(inventory);
                  // Set the Selected inventory to Update
                  _selectedInventory = inventory;
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
              DataCell(IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {

                },
              ))
            ]),
          ).toList(),
        ),
      ),
    );
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress), // we show the progress in the title...
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {

            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getInventory();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _whatController,
                decoration: InputDecoration.collapsed(
                  hintText: 'What',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _brandController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Brand',
                ),
              ),
            ),
            // Add an update button and a Cancel Button
            // show these buttons only when updating an employee
            _isUpdating
                ? Row(
              children: <Widget>[
                OutlineButton(
                  child: Text('UPDATE'),
                  onPressed: () {

                  },
                ),
                OutlineButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    setState(() {
                      _isUpdating = false;
                    });
                    _clearValues();
                  },
                ),
              ],
            )
                : Container(),
            Expanded(
              child: _dataBody(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: Icon(Icons.add),
      ),
    );
  }
}



/*class UserInvScreen extends StatelessWidget {
  static const String id = 'userinv_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize( // create App Bar
        preferredSize: Size.fromHeight(125.0),
        child: AppBarComponent(
          title: 'INVENTORY',
          leftIcon: Icon(Icons.arrow_back_ios),
          invisibleRightIcon: true,
          leftOnPressed: () {
            Navigator.pop(context); // go back to home_screen
          },
        ),
      ),

    );
  }
}*/
