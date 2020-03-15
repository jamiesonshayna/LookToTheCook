import 'package:look_to_the_cook/classes/basic_item.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 03/14/2020
Last Modified: 03/14/2020
File Name: shopping_item.dart
Version: 1.0
Description: This class allows the user to create shopping item objects. Creating a shopping object
allows the application to package these properties and easily send them to the PHP file on the server as
data that can be used to run the crud queries. Being able to collect this data on any screen
and update as a response to user input makes it very easy to create new items in inventory as well as
debug with the basicDisplay override method.
 */
class ShoppingItem extends BasicItem {
  double _howMany;
  bool _purchased;
  bool _archived;

  /*
  This method constructs a new Shopping Item object. (also calls parent's constructor)

  @param String name of the shopping list item.
  @param String brand of the shopping list item.
  @param double size of the shopping list item.
  @param double howMany of the shopping list item.
  @param bool purchased status of the shopping list item.
  @param bool archived status of the shopping list item.
   */
  ShoppingItem(String name, String brand, double size, double howMany,
      bool purchased, bool archived)
      : super(name, brand, size) {
    _howMany = howMany;
    _purchased = purchased;
    _archived = archived;
  }

  @override // override needs no documentation (inherits from parent)
  String basicDisplay() {
    return "Name: " + super.getName() + ", Brand: " + super.getBrand()
        + ", Size: " + super.getSize().toString() + "How Many: " +
        _howMany.toString() +
        "Purchased: " + _purchased.toString() + "Archived: " + _archived.toString();
  }

  /*
  This method returns shopping list item quantity desired.

  @return double how many items needed.
   */
  double getHowMany() {
    return _howMany;
  }

  /*
  This method returns whether or not the item was purchased.

  @return bool shopping list item purchased status.
   */
  bool getPurchased() {
    return _purchased;
  }

  /*
  This method returns whether or not the item is to be archived.

  @return bool shopping list item archive status.
   */
  bool getArchived() {
    return _archived;
  }

  /*
  This method sets shopping list item quantity desired.

  @param double how many items needed to be purchased.
   */
  setHowMany(double howMany) {
    _howMany = howMany;
  }

  /*
  This method sets the purchased status of the shopping list item.

  @param bool purchased status.
   */
  setPurchased(bool purchased) {
    _purchased = purchased;
  }

  /*
  This method sets the archived status of the shopping list item.

  @param bool archived status.
   */
  setArchived(bool archived) {
    _archived = archived;
  }
}