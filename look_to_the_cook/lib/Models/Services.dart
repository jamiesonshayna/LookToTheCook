

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:look_to_the_cook/classes/Inventory.dart';
import 'package:look_to_the_cook/classes/secure_storage_class.dart';


/*
Authors: Shayna Jamieson & Rob Wood
Date Created: 1/30/2020
Last Modified: 03/11/2020
File Name: Services.dart
Version: 2.0

Description:
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
  static const _DELETE_SHOP_ACTION = 'DELETE_SHOP';
  static const _SHOP_TO_INV_ACTION = 'SHOP_TO_INV';
  static const _SHOP_ALL_TO_INV_ACTION = 'SHOP_ALL_TO_INV';


  static Future<List<Inventory>> getInventory() async {
    SecureStorage storage = new SecureStorage();
    String userEmail = await storage.readFromStorage('email');
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      map['email'] = userEmail;
      final response = await http.post(ROOT, body: map);
      print('getEmployees Response: ${response.body}');
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

  static List<Inventory> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Inventory>((json) => Inventory.fromJson(json)).toList();
  }

  // Method to add inventory item to the database...
  static Future<String> addItem(String what,
      String brand, String size, String alert, String alertQty,
      String invList, String invListQty, String shoppingList,
      String shoppingListQty, String notes, String where) async {
    SecureStorage storage = new SecureStorage();
    String userEmail = await storage.readFromStorage('email');

    try {
      var map = Map<String, dynamic>();
      if(where == "shopping"){
        map['action'] = _ADD_SHOP_ACTION;
      }
      else{
        map['action'] = _ADD_INV_ACTION;
      }

    //  map['email'] = userEmail;
      map['what'] = what;
      map['brand'] = brand;
      map['size'] = size;
      map['alert'] = alert;
      map['alertQty '] = alertQty;
      map['invList'] = invList;
      map['invListQty'] = invListQty;
      map['shoppingList'] = shoppingList;
      map['shoppingListQty'] = shoppingListQty;
      map['notes'] = notes;
      map['userId'] = userEmail;

      final response = await http.post(ROOT, body: map);
      print('addItem Response: ${response.body}');
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
    String userEmail = await storage.readFromStorage('email');
    try {
      var map = Map<String, dynamic>();
      if(where == "shopping"){
        map['action'] = _UPDATE_SHOP_ACTION;
      }
      else{
        map['action'] = _UPDATE_INV_ACTION;
      }

      // change this to item list
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
      // map['userId '] = userEmail;

      final response = await http.post(ROOT, body: map);
      print('updateItem Response: ${response.body}');
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
    String userEmail = await storage.readFromStorage('email');
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_INV_ACTION;
      map['email'] = userEmail;
      map['inventoryId'] = inventoryId;
      final response = await http.post(ROOT, body: map);
      print('deleteItem Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }

  static Future<List<Inventory>> getShopping() async {
    SecureStorage storage = new SecureStorage();
    String userEmail = await storage.readFromStorage('email');
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_SHOP_ACTION;
      map['email'] = userEmail;
      final response = await http.post(ROOT, body: map);
      print('getShoppingResponse: ${response.body}');
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


  static Future<String> shopToInv(
  String inventoryId, String shoppingListQty) async {
    SecureStorage storage = new SecureStorage();
    String userEmail = await storage.readFromStorage('email');
    try {
      var map = Map<String, dynamic>();
      map['action'] = _SHOP_TO_INV_ACTION;
     // map['email'] = userEmail;
      map['inventoryId'] = inventoryId;
   /*   map['what'] = what;
      map['branc'] = brand;
      map['size'] = size;
      map['alert'] = alert;
      map['alertQty '] = alertQty;
      map['invList'] = invList;
      map['invListQty'] = invListQty;
      map['shoppingList'] = shoppingList;*/
      map['shoppingListQty'] = shoppingListQty;
     // map['notes'] = notes;
    //  map['email'] = userEmail;
      final response = await http.post(ROOT, body: map);
      print('getShoppingResponse: ${response.body}');
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


  static Future<String> shopAllToInv( ) async {
    SecureStorage storage = new SecureStorage();
    String userEmail = await storage.readFromStorage('email');
    try {
      var map = Map<String, dynamic>();
      map['action'] = _SHOP_ALL_TO_INV_ACTION;

      map['email'] = userEmail;
      final response = await http.post(ROOT, body: map);
      print('getShoppingResponse: ${response.body}');
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
