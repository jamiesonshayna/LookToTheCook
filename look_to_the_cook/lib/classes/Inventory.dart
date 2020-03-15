/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 02/02/2020
Last Modified: 03/14/2020
File Name: Inventory.dart
Version: 2.0
Description: This class allows the program to create user inventory item
objects. These objects can be used throughout any of the views to display
properties.
 */

class Inventory{
  String inventoryId;
  String what;
  String brand;
  String size;
  String alert;
  String alertQty;
  String invList ;
  String invListQty;
  String shoppingList;
  String shoppingListQty;
  String notes;
  String userId;

  /*
  Constructs a Inventory object.

  @param String inventoryId of the inventory item object.
  @param String what of the inventory item object.
  @param String brand of the inventory item object.
  @param String size of the inventory item object.
  @param String alert of the inventory item object.
  @param String alertQty of the inventory item object.
  @param String invList of the inventory item object.
  @param String invListQty of the inventory item object.
  @param String shoppingList of the inventory item object.
  @param String shoppingListQty of the inventory item object.
  @param String notes of the inventory item object.
  @param String userId of the inventory item object.
   */
  Inventory({this.inventoryId, this.what, this.brand, this.size, this.alert,
   this.alertQty, this.invList, this.invListQty, this.shoppingList,
    this.shoppingListQty, this.notes, this.userId});

  factory Inventory.fromJson(Map<String, dynamic> json){
    return Inventory(
      inventoryId: json['inventoryId'] as String,
      what: json['what'] as String,
      brand: json['brand'] as String,
      size: json['size'] as String,
      alert: json['alert'] as String,
      alertQty: json['alertQty'] as String,
      invList: json['invList'] as String,
      invListQty: json['invListQty'] as String,
      shoppingList: json['shoppingList'] as String,
      shoppingListQty: json['shoppingListQty'] as String,
      notes: json['notes'] as String,
      userId: json['userId'] as String
    );
  }
}
