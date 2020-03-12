import 'package:flutter/material.dart';
// Database class
import 'package:look_to_the_cook/Models/Services.dart';
// Inventory class
import 'package:look_to_the_cook/classes/Inventory.dart';

// TEMPLATE COMPONENTS:
import 'package:look_to_the_cook/templates/constants.dart';

// ROUTES
import 'package:look_to_the_cook/views/home_screen.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 01/30/2020
Last Modified: 02/27/2020
File Name: user_inventory_screen.dart
Version: 2.0
Description: The purpose of this file is to build and render the user inventory screen.
The screen.......... TODO: BUILD OUT THIS HEADER ONCE BUILT
 */

class UserInvScreen extends StatefulWidget{
  static const String id = 'userinv_screen';
  UserInvScreen() : super();
  final String title = "Inventory List";

  @override
  item createState() => item();
}

class item extends State<UserInvScreen>{
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
  bool alertValue = false;
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
    Services.updateItem(
         item.inventoryId, _whatController.text,
         _brandController.text, _sizeController.text, _alertController.text,
      _alertQtyController.text, _invListController.text, _invListQtyController.text,
     _shoppingListController.text,  _shoppingListQtyController.text, _notesController.text,
    _userIdController.text, "inventory")
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
  // add an Item
  _addItem() {
    // wont let you if either what or brand is empty
    if (_whatController.text.isEmpty || _brandController.text.isEmpty) {
      print('Empty Fields');
      return;
    }
    // shows progress of adding item
    _showProgress('Adding Item...');

    Services.addItem(
        _whatController.text,
        _brandController.text, _sizeController.text, _alertController.text,
        _alertQtyController.text, _invListController.text, _invListQtyController.text,
        _shoppingListController.text,  _shoppingListQtyController.text, _notesController.text,"inventory").then((result) {
      if ('success' == result) {
        _getInventory(); // Refresh the List after adding each item
        _clearValues(); // clear the text boxes
      }
    });
  }
  // deletes the item
  _deleteItem(Inventory item) {
    // progress bar status
    _showProgress('Deleting Inventory...');
    Services.deleteItem(item.inventoryId).then((result) {
      if ('success' == result) {
        _clearValues();
        _getInventory(); // Refresh after delete...
      }
    });
  }
  // Method to clear TextField values
  _clearValues() {
    _whatController.text = '';
    _brandController.text = '';
    _sizeController.text = '';
    _alertController.text = '';
    _alertQtyController.text = '';
    _invListController.text = '';
    _invListQtyController.text = '';
    _notesController.text = '';
  }

  _showValues(Inventory inventory) {
    _whatController.text = inventory.what;
    _brandController.text = inventory.brand;
    _sizeController.text = inventory.size;
    _alertController.text = inventory.alert;

    _alertQtyController.text = inventory.alertQty;
    _invListController.text = inventory.invList;
    _invListQtyController.text = inventory.invListQty;
    _notesController.text = inventory.notes;
  }// DataTable and show the item list in it.
  SingleChildScrollView _dataBody() {
    // Both Vertical and Horizontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('What'),
            ),
            DataColumn(
              label: Text('Brand'),
            ),
           /* DataColumn(
              label: Text('Size'),
            ),*/
            // column to show a delete button
            DataColumn(
              label: Text('DELETE'),
            )
          ],
          rows: _inventory
              .map(
                (inventory) => DataRow(cells: [
              DataCell(
                Text(inventory.what.toUpperCase()),
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
                  inventory.brand.toUpperCase(),
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
            /*  DataCell(
                Text(inventory.size),
                onTap: () {
                  _showValues(inventory);
                  // Set the Selected inventory to Update
                  _selectedInventory = inventory;
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),*/
              DataCell(IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deleteItem(inventory);
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(62.0),
        child:  AppBar(
          leading: IconButton( // display or hide the left App Bar icon
            onPressed: () {
              Navigator.pushNamed(context, HomeScreen.id);
            },
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 35.0,
            color: Colors.white,
          ),
          backgroundColor: kRedButtonColor,
          title: Text(_titleProgress, style:
            TextStyle(
              fontSize: 30.0
            ),), // we show the progress in the title
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              iconSize: 35.0,
              onPressed: () {
                _addItem();
              },
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              iconSize: 35.0,
              onPressed: () {
                _getInventory();
              },
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15.0),
                child:SizedBox(
                  width: 100.0,
                  child:TextField(
                    controller: _whatController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Item Name',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child:SizedBox(
                  width: 100.0,
                  child:TextField(
                    controller: _brandController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Brand',
                    ),
                  ),
                ),
              ),
         // to space
              Padding(
                padding: EdgeInsets.all(15.0),
                child:SizedBox(
                  width: 50.0,
                  child:TextField(
                    controller: _sizeController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Size',
                    ),
                  ),
                ),
              ),
          ]),
            Row(
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Checkbox(
                      activeColor: kRedButtonColor,
                      value: alertValue,
                      onChanged: (value ) {
                        setState(() {
                          alertValue = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 30.0),
                      child: Text(" ", style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15.0
                      ),),),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child:SizedBox(
                      width: 100.0,
                      child:TextField(
                        controller: _alertQtyController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'add at?',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child:SizedBox(
                      width: 85.0,
                      child:TextField(
                        controller: _invListQtyController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'QTY?',
                        ),
                      ),
                    ),
                  ),
                  // to space
                ]),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child:SizedBox(
                    width: 250.0,
                    child:TextField(
                      controller: _notesController,
                      decoration: InputDecoration.collapsed(
                      hintText: 'Notes',
                    ),
                  ),
                ),
              ),
            ]),

            // Add an update and  Cancel Button only when updating an item
            _isUpdating
                ? Row(
              children: <Widget>[
                OutlineButton(
                  child: Text('UPDATE'),

                  onPressed: () {
                    _updateItem(_selectedInventory);
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
    );
  }
}


