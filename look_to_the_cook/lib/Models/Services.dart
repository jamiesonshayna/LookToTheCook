

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:look_to_the_cook/classes/Inventory.dart';
import 'package:look_to_the_cook/classes/secure_storage_class.dart';


/*
Authors: Shayna Jamieson & Rob Wood
Date Created: 1/30/2020
Last Modified: 03/11/2020
File Name: Services.dart
Version: 3.0

Description: This file will communicate with the php database file that will
interact with the database. This file will control the adding, deleting,
editing, and getting of all the info from the database for the shopping list
and the inventory list.
 */

class Services {
  // variable to access the database file
  static const ROOT = 'https://rwood.greenriverdev.com/328/LookDB.php';
  // custom variables for the php database interaction file
    // inventory variables
  static const _GET_ALL_ACTION = 'GET_INV';
  static const _ADD_INV_ACTION = 'ADD_INV';
  static const _UPDATE_INV_ACTION = 'UPDATE_INV';
  static const _DELETE_INV_ACTION = 'DELETE_INV';
    // shopping variables
  static const _GET_ALL_SHOP_ACTION = 'GET_SHOP';
  static const _ADD_SHOP_ACTION = 'ADD_SHOP';
  static const _UPDATE_SHOP_ACTION = 'UPDATE_SHOP';
  static const _DELETE_SHOP_ACTION = 'DELETE_SHOP'; // TODO: check if needed
  static const _SHOP_TO_INV_ACTION = 'SHOP_TO_INV';
  static const _SHOP_ALL_TO_INV_ACTION = 'SHOP_ALL_TO_INV';

  // This will get the inventory items from the database
  static Future<List<Inventory>> getInventory() async {
    SecureStorage storage = new SecureStorage();
    // to get the logged in users email
    String userEmail = await storage.readFromStorage('email');
    try {
      // returns the inventory of the user if exists
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      map['email'] = userEmail;
      final response = await http.post(ROOT, body: map);
      print('getInventory Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Inventory> list = parseResponse(response.body);
        print("GOOD");
        return list;
      }
      // if no inventory exists returns blank list
      else {
        return List<Inventory>();
      }
    }
    catch (e) {
      return List<Inventory>(); // return an empty list on exception/error
    }
  }

  // to parse through the results of a list
  static List<Inventory> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Inventory>((json) => Inventory.fromJson(json)).toList();
  }

  // Method to add inventory item to the database...
 static  Future<String> addItem(String what,
      String brand, String size, String alert, String alertQty,
      String invList, String invListQty, String shoppingList,
      String shoppingListQty, String notes, String where) async {
    SecureStorage storage = new SecureStorage();
    // to get the logged in users email
    String userEmail = await storage.readFromStorage('email');

    if(where == "shopping") {
      if((double.tryParse(alertQty) != null && double.tryParse(shoppingListQty) != null)) {
        if(int.parse(alertQty) < 0 ||  int.parse(shoppingListQty) < 0 ){
          return "negative error";
        }
      } else {
        return "negative error";
      }
    } else {
      if((double.tryParse(alertQty) != null && double.tryParse(invListQty) != null)) {
        if(int.parse(alertQty) < 0 || int.parse(invListQty) < 0 ){
          return "negative error";
        }
      } else {
        return "negative error";
      }
    }

    try {
      var map = Map<String, dynamic>();
      // to add item based on what where is to shopping list or inventory

      if(where == "shopping"){
        map['action'] = _ADD_SHOP_ACTION;
      }
      else{
        map['action'] = _ADD_INV_ACTION;
      }

      map['what'] = what;
      map['brand'] = brand;
      map['size'] = size;
      map['alert'] = alert;
      map['alertQty'] = alertQty;
      map['invList'] = invList;
      map['invListQty'] = invListQty;
      map['shoppingList'] = shoppingList;
      map['shoppingListQty'] = shoppingListQty;
      map['notes'] = notes;
      map['userId'] = userEmail;
      if(alertQty == invListQty){
        map['shoppingList'] = "1";
        map['shoppingListQty'] = invListQty;
      }
      final response = await http.post(ROOT, body: map);
      print('addItem Response: ${response.body}');

      // returns if the add is successful or not
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to update an inventory Item in Database...
  static Future<String> updateItem(//Inventory item) async {
       String inventoryId,String what, String brand, String size,
      String alert,String alertQty,String invList,String invListQty,
      String shoppingList,String shoppingListQty,String notes,String userId, String where) async {
    SecureStorage storage = new SecureStorage();
    // to get the logged in users email
    String userEmail = await storage.readFromStorage('email');
    try {
      var map = Map<String, dynamic>();
      if(where == "shopping"){
        map['action'] = _UPDATE_SHOP_ACTION;
      }
      else{
        map['action'] = _UPDATE_INV_ACTION;
      }
      map['email'] = userEmail;
      map['inventoryId'] = inventoryId;
      map['what'] = what;
      map['brand'] = brand;
      map['size'] = size;
      map['alert'] = alert;
      map['alertQty'] = alertQty;
      map['invList'] = invList;
      map['invListQty'] = invListQty;
      map['shoppingList'] = shoppingList;
      map['shoppingListQty'] = shoppingListQty;
      map['notes'] = notes;
      map['userId '] = userEmail;

      final response = await http.post(ROOT, body: map);
      print('updateItem Response: ${response.body}');
      // return if successful or not
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to Delete an inventory item from Database...
  static Future<String> deleteItem(String inventoryId) async {
    SecureStorage storage = new SecureStorage();
    // to get the logged in users email
    String userEmail = await storage.readFromStorage('email');
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_INV_ACTION;
      map['email'] = userEmail;
      map['inventoryId'] = inventoryId;
      final response = await http.post(ROOT, body: map);
      print('deleteItem Response: ${response.body}');
      // returns if the add is successful or not
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }

  // will get the items on the shopping list
  static Future<List<Inventory>> getShopping() async {
    SecureStorage storage = new SecureStorage();
    // to get the logged in users email
    String userEmail = await storage.readFromStorage('email');
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_SHOP_ACTION;
      map['email'] = userEmail;
      final response = await http.post(ROOT, body: map);
      print('getShoppingResponse: ${response.body}');
      // returns if the add is successful or not
      if (200 == response.statusCode) {
        List<Inventory> list = parseResponse(response.body);
        print("GOOD");
        return list;
      }
      else {
        return List<Inventory>();
      }
    }
    catch (e) {
      return List<Inventory>(); // return an empty list on exception/error
    }
  }

  // this method will move items from shopping list to inventory
  static Future<String> shopToInv(
    String inventoryId, String shoppingListQty, String invListQty) async {
    SecureStorage storage = new SecureStorage();
    // to get the logged in users email
    String userEmail = await storage.readFromStorage('email');
    try {
      var map = Map<String, dynamic>();
      map['action'] = _SHOP_TO_INV_ACTION;
      map['inventoryId'] = inventoryId;
      map['shoppingListQty'] = shoppingListQty;
      map['invListQty'] = invListQty;
      final response = await http.post(ROOT, body: map);
      print('getShoppingResponse: ${response.body}');
      // returns if the add is successful or not
      if (200 == response.statusCode) {
        // List<Inventory> list = parseResponse(response.body);
        String list = response.body;
        print("GOOD");
        return list;
      }
      else {
        return ""; //List<Inventory>();
      }
    }
    catch (e) {
      return "";// List<Inventory>(); // return an empty list on exception/error
    }
  }

  // this method will eventually move all from shopping to inventory
  static Future<String> shopAllToInv( ) async {
    SecureStorage storage = new SecureStorage();
    // to get the logged in users email
    String userEmail = await storage.readFromStorage('email');
    try {
      var map = Map<String, dynamic>();
      map['action'] = _SHOP_ALL_TO_INV_ACTION;
      map['email'] = userEmail;
      final response = await http.post(ROOT, body: map);
      print('getShoppingResponse: ${response.body}');
      // returns if the add is successful or not
      if (200 == response.statusCode) {
        // List<Inventory> list = parseResponse(response.body);
        String list = response.body;
        print("GOOD");
        return list;
      }
      else {
        return ""; //List<Inventory>();
      }
    }
    catch (e) {
      return "";// List<Inventory>(); // return an empty list on exception/error
    }
  }
}
