

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
}