
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
