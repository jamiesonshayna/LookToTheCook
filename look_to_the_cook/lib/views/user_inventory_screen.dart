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

 /* what, brand, size, alert, alertQty,
  invList, invListQty, shoppingList,
  shoppingListQty, notes, userId*/
  TextEditingController _itemIdController;
  // controller for the What TextField we are going to create.
  TextEditingController _whatController;
  // controller for the brand TextField we are going to create.
  TextEditingController _brandController;
  // controller for the First Name TextField we are going to create.
  TextEditingController _sizeController;
  // controller for the Last  TextField we are going to create.
  TextEditingController _alertController;
  // controller for the First  TextField we are going to create.
  TextEditingController _alertQtyController;
  // controller for the Last  TextField we are going to create.
  TextEditingController _invListController;
  // controller for the invList TextField we are going to create.
  TextEditingController _invListQtyController;
  // controller for the Last  TextField we are going to create.
  TextEditingController _shoppingListController;
  // controller for the First  TextField we are going to create.
  TextEditingController _shoppingListQtyController;
  // controller for the Last  TextField we are going to create.
  TextEditingController _notesController;
  // controller for the Last  TextField we are going to create.
  TextEditingController _userIdController;
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
    _itemIdController =TextEditingController();
    _whatController = TextEditingController();
    _brandController = TextEditingController();
    _sizeController = TextEditingController();
    _alertController = TextEditingController();
    _alertQtyController = TextEditingController();
    _invListController = TextEditingController();
    _invListQtyController = TextEditingController();
    _shoppingListController = TextEditingController();
    _shoppingListQtyController = TextEditingController();
    _notesController = TextEditingController();
    _userIdController = TextEditingController();
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
  _updateItem(Inventory item) {
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating Item...');
    Services.updateItem(_itemIdController.text,
        _whatController.text,
        _brandController.text, _sizeController.text, _alertController.text,
    _alertQtyController.text, _invListController.text, _invListQtyController.text,
    _shoppingListController.text,  _shoppingListQtyController.text, _notesController.text,
    _userIdController.text)
        .then((result) {
      if ('success' == result) {
        _getInventory(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }
  // Now lets add an Item
  _addItem() {
    if (_whatController.text.isEmpty || _brandController.text.isEmpty) {
      print('Empty Fields');
      return;
    }
    _showProgress('Adding Item...');
    Services.addItem( _whatController.text, _brandController.text,
        _sizeController.text, true,1, true, 1, true, 1, _notesController.text, 1)
        .then((result) {
      if ('success' == result) {
        _getInventory(); // Refresh the List after adding each employee...
        _clearValues();
      }
    });
  }
  _deleteItem(Inventory item) {
    _showProgress('Deleting Inventory...');
    Services.deleteItem(item.inventoryId).then((result) {
      if ('success' == result) {
        _getInventory(); // Refresh after delete...
      }
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
                 // _deleteItem(item); //88888888888888888888888888888888888888888888888
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
              _addItem();
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
                //    _updateItem(  ); ////////////////////////////////////////////////////////////
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
          _addItem();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


