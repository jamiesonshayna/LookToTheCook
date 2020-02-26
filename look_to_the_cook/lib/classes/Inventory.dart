
class Inventory{
  int inventoryId;
  String what;
  String brand;
  String size;
  bool alert;
  int alertQty;
  bool invList ;
  int invListQty;
  bool shoppingList;
  String shoppingListQty;
  String notes;
  int userId;

  Inventory({this.inventoryId, this.what, this.brand}); // add rest of fields later

  factory Inventory.fromJson(Map<String, dynamic> json){
    return Inventory(
      inventoryId: json['inventoryId'] as int,
      what: json['what'] as String,
      brand: json['brand'] as String,
    );
  }
}
