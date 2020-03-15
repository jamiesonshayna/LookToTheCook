import 'package:look_to_the_cook/classes/basic_item.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 03/14/2020
Last Modified: 03/14/2020
File Name: inventory_item.dart
Version: 1.0
Description: This class allows the user to create inventory item objects. Creating an inventory object
allows the application to package these properties and easily send them to the PHP file on the server as
data that can be used to run the insert new item queries. Being able to collect this data on any screen
and update as a response to user input makes it very easy to create new items in inventory as well as
debug with the basicDisplay override method.
 */
class InventoryItem extends BasicItem {
  bool _alert;
  double _alertQuantity;
  double _quantity;
  bool _shoppingList;
  String _notes;

  /*
  This method constructs a new Inventory Item object. (also calls parent's constructor)

  @param String name of the inventory item object.
  @param String brand of the inventory item object.
  @param double size of the inventory item object.
  @param bool alert status for item object.
  @param double alertQuantity for item object.
  @param double quantity of item object.
  @param bool shoppingList status for item object.
  @param String notes for the inventory item object.
   */
  InventoryItem(String name, String brand, double size, bool alert, double alertQuantity,
      double quantity, bool shoppingList, String notes) : super(name, brand, size) {
    _alert = alert;
    _alertQuantity = alertQuantity;
    _quantity = quantity;
    _shoppingList = shoppingList;
    _notes = notes;
  }

  @override // override needs no documentation (inherits from parent)
  String basicDisplay() {
    return "Name: " + super.getName() + ", Brand: " + super.getBrand()
        + ", Size: " + super.getSize().toString() + "Alerts: " + _alert.toString() +
    "Alert Quantity: " + _alertQuantity.toString() + " Quantity: " + _quantity.toString()
    + "Shooping List: " + _shoppingList.toString() + "Notes: " + _notes;
  }

  /*
  This method returns alert status.

  @return bool alert status.
   */
  bool getAlert() {
    return _alert;
  }

  /*
  This method returns alert quantity.

  @return double alert quantity.
   */
  double getAlertQuantity() {
    return _alertQuantity;
  }

  /*
  This method returns item quantity.

  @return double item quantity.
   */
  double getQuantity() {
    return _quantity;
  }

  /*
  This method returns shopping list status.

  @return bool shopping list status.
   */
  bool getShoppingList() {
    return _shoppingList;
  }

  /*
  This method returns item notes.

  @return String item notes.
   */
  String getNotes() {
    return _notes;
  }

  /*
  This method sets alert status.

  @param bool new alert status.
   */
  setAlert(bool alert) {
    _alert = alert;
  }

  /*
  This method sets alert quantity.

  @param double new alert quantity.
   */
  setAlertQuantity(double alertQuantity) {
    _alertQuantity = alertQuantity;
  }

  /*
  This method sets item quantity.

  @param double new item quantity.
   */
  setQuantity(double quantity) {
    _quantity = quantity;
  }

  /*
  This method sets shopping list status.

  @param bool new shopping list status.
   */
  setShoppingList(bool shoppingList) {
    _shoppingList = shoppingList;
  }

  /*
  This method sets item notes.

  @param String new item notes.
   */
  setNotes(String notes) {
    _notes = notes;
  }
}