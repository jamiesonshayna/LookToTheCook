

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:look_to_the_cook/classes/Inventory.dart';

class Services {
  static const ROOT = 'https://rwood.greenriverdev.com/328/LookDB.php';

  static const _GET_ALL_ACTION = 'GET_INV';
  static const _ADD_INV_ACTION = 'ADD_INV';
  static const _UPDATE_INV_ACTION = 'UPDATE_INV';
  static const _DELETE_INV_ACTION = 'DELETE_INV';

  static Future<List<Inventory>> getInventory() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
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
      String brand, String size, bool alert, int alertQty,
      bool invList, int invListQty, bool shoppingList,
      int shoppingListQty, String notes, int userId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_INV_ACTION;

      map['what'] = what;
      map['branc'] = brand;
      map['size'] = size;
      map['alert'] = alert;
      map['alertQty '] = alertQty;
      map['invList'] = invList;
      map['invListQty'] = invListQty;
      map['shoppingList'] = shoppingList;
      map['shoppingListQty'] = shoppingListQty;
      map['notes'] = notes;
      map['userId '] = userId;

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
  static Future<String> updateItem(
       inventoryId, what, brand, size, alert, alertQty, invList, invListQty,
       shoppingList, shoppingListQty, notes, userId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_INV_ACTION;

      // change this to item list
      map['inventoryId'] = inventoryId;
      map['what'] = what;
      map['branc'] = brand;
      map['size'] = size;
      map['alert'] = alert;
      map['alertQty '] = alertQty;
      map['invList'] = invList;
      map['invListQty'] = invListQty;
      map['shoppingList'] = shoppingList;
      map['shoppingListQty'] = shoppingListQty;
      map['notes'] = notes;
      map['userId '] = userId;

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
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_INV_ACTION;

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
}
