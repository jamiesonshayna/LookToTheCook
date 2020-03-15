/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 03/14/2020
Last Modified: 04/13/2020
File Name: basic_item.dart
Version: 1.0
Description: This class allows the program to create basic user inventory item objects. These
objects can be used throughout any of the views to display basic properties such as name,
brand, and size. Using this object is an option when not all details are needed to be reported
for a particular inventory item. It is light-weight, and allows for quick render.
 */
class BasicItem {
  String _itemName;
  String _itemBrand;
  double _itemSize;

  /*
  Constructs a Basic Item object.

  @param String name of the inventory item object.
  @param String brand of the inventory item object.
  @param double size of the inventory item object.
   */
  BasicItem(String name, String brand, double size) {
    _itemName = name;
    _itemBrand = brand;
    _itemSize = size;
  }

  /*
  This method returns a string with inventory item descriptions.

  @return String toString() display of inventory.
   */
  String basicDisplay() {
    return "Name: " + _itemName + ", Brand: " + _itemBrand
        + ", Size: " + _itemSize.toString();
  }

  /*
  This method returns the item name.

  @return String name.
   */
  String getName() {
    return _itemName;
  }

  /*
  This method returns the item brand.

  @return String brand.
   */
  String getBrand() {
    return _itemBrand;
  }

  /*
  This method returns the item size.

  @return double size.
   */
  double getSize() {
    return _itemSize;
  }

  /*
  This method updates the item name.

  @param String name.
   */
  setName(String name) {
    _itemName = name;
  }

  /*
  This method updates the item brand.

  @param String brand.
   */
  setBrand(String brand) {
    _itemBrand = brand;
  }

  /*
  This method updates the item size.

  @param double size.
   */
  setSize(double size) {
    _itemSize = size;
  }
}