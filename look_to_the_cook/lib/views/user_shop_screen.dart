import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// INVENTORY & DATABASE CLASSES:
import 'package:look_to_the_cook/classes/Inventory.dart';
import 'package:look_to_the_cook/Models/Services.dart';

// TEMPLATE COMPONENTS:
import 'package:look_to_the_cook/templates/constants.dart';

// ROUTES
import 'package:look_to_the_cook/views/home_screen.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 01/30/2020
Last Modified: 03/14/2020
File Name: user_shop_screen.dart
Version: 3.0
Description: The purpose of this file is to build and render the user
shopping list screen.
The screen will show the logged in user all the items on their shopping list.
Will also allow them to click the purchased button and move the item to inventory.
 */
class UserShopScreen extends StatefulWidget {
  static const String id = 'UserShop_screen';

  UserShopScreen() : super();
  final String title = "Shopping List";

  @override
  item createState() => item();
}

class item extends State<UserShopScreen>{
  List<Inventory> _inventory;
  GlobalKey<ScaffoldState> _scaffoldKey;

  TextEditingController _itemIdController;
  // controller for the What TextField we are going to create.
  TextEditingController _whatController;
  // controller for the brand TextField we are going to create.
  TextEditingController _brandController;
  // controller for the size  TextField we are going to create.
  TextEditingController _sizeController;
  // controller for the alert TextField we are going to create.
  TextEditingController _alertController;
  // controller for the alert Qty   TextField we are going to create.
  TextEditingController _alertQtyController;
  // controller for the if in inventory   TextField we are going to create.
  TextEditingController _invListController;
  // controller for the invList qty  extField we are going to create.
  TextEditingController _invListQtyController;
  // controller for the invList qty  TextField we are going to create.
  TextEditingController _shoppingListController;
  // controller for the shopping list qty TextField we are going to create.
  TextEditingController _shoppingListQtyController;
  // controller for the notes TextField we are going to create.
  TextEditingController _notesController;
  // controller for the Last  TextField we are going to create.
  TextEditingController _userIdController;
  Inventory _selectedShopping;
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
    _getShopping();
  }
  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  // calls the services class to get the shopping list results
  _getShopping() async {
    _showProgress('Loading Inventory...');
    await Services.getShopping().then((inventories) {
      setState(() {
        _inventory = inventories;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${inventories.length}");
    });
  }
  // update the item
  Future <bool> _updateItem(Inventory item) async {
    bool isSuccess = true;
    // tells the state that we are updating
    setState(() {
      _isUpdating = true;
    });
    // show progress on the title bar
    _showProgress('Updating Item...');
    // updates item
    await Services.updateItem(
        item.inventoryId, _whatController.text,
        _brandController.text, _sizeController.text, _alertController.text,
        _alertQtyController.text, item.invList,
        item.invListQty, _shoppingListController.text,
        _shoppingListQtyController.text, _notesController.text,
        _userIdController.text, "shopping")
        .then((result) {
      // return success results
      if ('success' == result) {
        _getShopping(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      } else if('negative error' == result) {
        isSuccess = false;
        _getShopping(); // Refresh the List after adding each item
      }
    });

    return isSuccess;
  }
  // add an Item
  Future<bool> _addItem() async {
    bool isSuccess = true;
    // wont let you if  what  is empty
    if (_whatController.text.isEmpty) {
      print('Empty Fields');
      return false;
    }
    // shows progress of adding item
    _showProgress('Adding Item...');
    // adds item
    await Services.addItem(
        _whatController.text,
        _brandController.text, _sizeController.text, _alertController.text,
        _alertQtyController.text, _invListController.text,
        _invListQtyController.text, _shoppingListController.text,
        _shoppingListQtyController.text, _notesController.text,
        "shopping").then((result) {
      // if add is successful returns results
      if ('success' == result) {
        _getShopping(); // Refresh the List after adding each item
        _clearValues(); // clear the text boxes
      } else if('negative error' == result) {
        isSuccess = false;
        _getShopping(); // Refresh the List after adding each item
      }
    });

    return isSuccess;
  }
  // will be used to move all items from shopping list to inventory list
  _inventoryAllItemsFromShopping(){
    // progress bar status
    _showProgress('Moving to Inventory...');
    Services.shopAllToInv().then((result) {
      if ('success' == result) {
        _clearValues();
        _getShopping(); // Refresh after delete...
      }
    });
  }
  // removes item from shopping list and moves to inventory
  _inventoryItemFromShopping(Inventory item) async {
    // progress bar status
    _showProgress('Moving to Inventory...');
    await Services.shopToInv(item.inventoryId, item.shoppingListQty, item.invListQty).then((result) {
      if ('success' == result) {
        _clearValues();
        _getShopping(); // Refresh after delete...
      }
    });
  }

  // deletes the item
  _deleteItem(Inventory item) async {
    // progress bar status
    _showProgress('Deleting Inventory...');
    await Services.deleteItem(item.inventoryId).then((result) {
      if ('success' == result) {
        _clearValues();
        _getShopping(); // Refresh after delete...
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
    _shoppingListController.text = '';
    _shoppingListQtyController.text = '';
    _notesController.text = '';
  }

  _showValues(Inventory inventory) {
    _whatController.text = inventory.what.toUpperCase();
    _brandController.text = inventory.brand.toUpperCase();
    _sizeController.text = inventory.size.toUpperCase();
    _alertController.text = inventory.alert;

    _alertQtyController.text = inventory.alertQty;
    _shoppingListController.text = inventory.shoppingList;
    _shoppingListQtyController.text = inventory.shoppingListQty;
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
/*            DataColumn(
              label: Text('Brand'),
            ),*/
            DataColumn(
              label: Text('Bought'),
            ),
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
                  _selectedShopping = inventory;
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
              DataCell(IconButton(

                icon: Icon(Icons.remove_shopping_cart),
                onPressed: () {
                  _inventoryItemFromShopping(inventory);
                },
                ),
              ),
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
            ),
          ), // we show the progress in the title
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              iconSize: 35.0,
              onPressed: () async {
                bool isSuccess = await _addItem();
                if(isSuccess == false) {
                  Alert(
                    context: context,
                    title: "Invalid quantities. Please enter values 0 or greater.",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        width: 120,
                        color: Colors.black,
                      )
                    ],
                  ).show();
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              iconSize: 35.0,
              onPressed: () {
                _getShopping();
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text("Add To Shopping At",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15.0
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child:SizedBox(
                        width: 55.0,
                        child:TextField(
                          controller: _alertQtyController,
                          decoration: InputDecoration.collapsed(
                            hintText: 'qty',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child:SizedBox(
                        width: 75.0,
                        child: Text('Buy'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child:SizedBox(
                        width: 45.0,
                        child:TextField(
                          controller: _shoppingListQtyController,
                          decoration: InputDecoration.collapsed(
                            hintText: 'qty',
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
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
//                    OutlineButton(
//                      child: Text('Purchased All'),
//                      onPressed: () {
//                        _inventoryAllItemsFromShopping();
//                      },
//                    ),
                ]),
            // Add an update and  Cancel Button only when updating an item
            _isUpdating
                ? Row(
              children: <Widget>[
                OutlineButton(
                  child: Text('UPDATE'),
                  onPressed: () async {
                    bool isSuccess = await _updateItem(_selectedShopping);
                    if(isSuccess == false) {
                      Alert(
                        context: context,
                        title: "Invalid quantities. Please enter values 0 or greater.",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "OK",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                            color: Colors.black,
                          )
                        ],
                      ).show();
                    }
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



