<?php
// echo "test";
// this file lets us connect to the database
require('/home4/woodrdkc/lookConnect.php');

// the table we want to access
$table = "inventory";
// we will get actions from the app to do operations in the database
$action = $_POST["action"];
// users email address
$userId = $_POST["email"];

// Get all inventory records from the database
if ("GET_INV" == $action) {
    $db_data = array();
    $sql = "SELECT * from $table where invlist is true AND userId = '$userId' ORDER BY what";
    $result = $cnxn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $db_data[] = $row;
        }
        // Send back the complete records as a json
        echo json_encode($db_data);
    }
    else {
        echo "error";
    }
    $cnxn->close();
    return;
}

// Add an Item to inventory
if ("ADD_INV" == $action || "ADD_SHOP" == $action) {
    // App will be posting these values to this server
    $goodOrBad = true;
    $what = $_POST['what'];
    $what = str_replace("'", "''", $what);
    $brand = $_POST['brand'];
    $brand = str_replace("'", "''", $brand);
    $size = $_POST['size'];
    $size = str_replace("'", "''", $size);
    $alert = (bool)$_POST['alert']; // bool
    $alertQty = (int)$_POST['alertQty']; // int
    $invListQty = (int)$_POST['invListQty']; // int
    if("ADD_INV" == $action){
        $invList = true; // bool
        $shoppingList = false;
        if($alertQty == $invListQty){
            $shoppingList = true;
        }
    }
    else{
        $shoppingList = true; //(bool)$_POST['shoppingList']; // bool
        $invList = false;
    }

    $shoppingListQty = (int)$_POST['shoppingListQty']; // int
    $notes = $_POST['notes'];
    $userId = $_POST['userId'];

    if($goodOrBad == false){
        return "fail";
    }
    else{
        $sql = "INSERT INTO $table (what, brand, size, alert, alertQty,
    invList, invListQty, shoppingList,
    shoppingListQty, notes, userId)
     VALUES ( '$what', '$brand', '$size', '$alert', '$alertQty', '$invList', '$invListQty', '$shoppingList',
    '$shoppingListQty', '$notes', '$userId' )";
        $result = $cnxn->query($sql);
        echo "success";
        $cnxn->close();
        return;
    }

}

// Update an Item
if ("UPDATE_INV" == $action || "UPDATE_SHOP" == $action) {
    // App will be posting these values to this server
    $inventoryId = $_POST['inventoryId'];
    $what = $_POST['what'];
    $brand = $_POST['brand'];
    $size = $_POST['size'];
    $alert = (bool)$_POST['alert']; // bool
    $alertQty = (int)$_POST['alertQty']; // int
    $invList = (bool)$_POST['invList']; // bool
    $invListQty = (int)$_POST['invListQty']; // int
    $shoppingList = (bool)$_POST['shoppingList']; // bool
    $shoppingListQty = (int)$_POST['shoppingListQty']; // int
    $notes = $_POST['notes'];
    $userId = $_POST['email'];

    $sql = "UPDATE $table SET what = '$what', brand = '$brand', size = '$size', alert = '$alert', 
    alertQty = '$alertQty', invList = '$invList', invListQty = '$invListQty', shoppingList = '$shoppingList',
    shoppingListQty = '$shoppingListQty', notes = '$notes', userId = '$userId'  WHERE inventoryId = $inventoryId";
    if ($cnxn->query($sql) === TRUE) {
        echo "success";
    }
    else {
        echo "error";
    }
    $cnxn->close();
    return;
}

// Delete an item
if ('DELETE_INV' == $action) {
    $inventoryId = $_POST['inventoryId'];
    $sql = "DELETE FROM $table WHERE inventoryId = $inventoryId";
    if ($cnxn->query($sql) === TRUE) {
        echo "success";
    }
    else {
        echo "error";
    }
    $cnxn->close();
    return;
}

// Delete all items from a user
if ('DELETE_ALL_USER_INV' == $action) {
    $sql = "DELETE FROM $table WHERE userId = '$userId' ";
    if ($cnxn->query($sql) === TRUE) {
        echo "success";
    }
    else {
        echo "error";
    }
    $cnxn->close();
    return;
}


// Get all shopping records from the database
if ("GET_SHOP" == $action) {
    $db_data = array();
    $sql = "SELECT * from $table where shoppingList is true AND userId = '$userId' ORDER BY what";
    $result = $cnxn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $db_data[] = $row;
        }
        // Send back the complete records as a json
        echo json_encode($db_data);
    }
    else {
        echo "error";
    }
    $cnxn->close();
    return;
}

// move item from shopping list to inventory
if ("SHOP_TO_INV" == $action ) {
    $inventoryId = $_POST['inventoryId'];
    $shoppingList = (bool)$_POST['shoppingList']; // bool
    $shoppingListQty = (int)$_POST['shoppingListQty']; // int
    $invListQty = (int)$_POST['invListQty'];
    $newShoppingListQty = $shoppingListQty + $invListQty;
    $sql = "UPDATE $table SET invList = '1', invListQty = '$newShoppingListQty', shoppingList = '0',
    shoppingListQty = '0'   WHERE inventoryId = $inventoryId";
    if ($cnxn->query($sql) === TRUE) {
        echo "success";
    }
    else {
        echo "error";
    }
    $cnxn->close();
    return;
}


if ("SHOP_ALL_TO_INV" == $action ) {
// NOT FUNCTIONING YET NEEDS WORK
    //$userId = $_POST['email'];
    // need ---> shoppingListQty, itemId
    $userId = "";
    $sql = "SELECT itemId, shoppingListQty from $table where shoppingList is true AND userId = $userId";
    $result = $cnxn->query($sql);
    $count = 0;
    $data = array();
    while ($row = $result->fetch_assoc()) {
        $count++;
        $data += [$row['itemId'] => $row['shoppingListQty']];
    }

    foreach($data as $id=>$qty){
        $sql2 = "UPDATE $table SET invList = '1', invListQty = '$qty', shoppingList = '0',
                shoppingListQty = '0' WHERE itemId = $id";
        $cnxn->query($sql2);
    }
    if ($cnxn->query($sql2) === TRUE) {
        echo "success";
    }
    else {
        echo "error";
    }
    $cnxn->close();
    return;
}

?>