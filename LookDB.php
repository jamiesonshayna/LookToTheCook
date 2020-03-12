<?php

// this file lets us connect to the database
require('/home/rwoodgre/connect2.php');

// the table we want to access
$table = "inventory";
// we will get actions from the app to do operations in the database
$action = $_POST["action"];
// users email address
$userId = $_POST["email"];

//$action = "GET_INV"; // for web testing
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
    $what = $_POST['what'];
    $brand = $_POST['brand'];
    $size = $_POST['size'];
    $alert = (bool)$_POST['alert']; // bool
    $alertQty = (int)$_POST['alertQty']; // int
    if("ADD_INV" == $action){
        $invList = true; // bool
        $shoppingList = false;
    }
    else{
        $shoppingList = true; //(bool)$_POST['shoppingList']; // bool
        $invList = false;
    }

    $invListQty = (int)$_POST['invListQty']; // int

    $shoppingListQty = (int)$_POST['shoppingListQty']; // int
    $notes = $_POST['notes'];
    $userId = $_POST['userId'];

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
    $userId = $_POST['userId'];

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
  /*  $what = $_POST['what'];
    $brand = $_POST['brand'];
    $size = $_POST['size'];
    $alert = (bool)$_POST['alert']; // bool
    $alertQty = (int)$_POST['alertQty']; // int*/
  //  $invList = (bool)$_POST['invList']; // bool
  //  $invListQty = (int)$_POST['invListQty']; // int
    $shoppingList = (bool)$_POST['shoppingList']; // bool
    $shoppingListQty = (int)$_POST['shoppingListQty']; // int
    /*$notes = $_POST['notes'];
    $userId = $_POST['userId'];*/

    $sql = "UPDATE $table SET invList = '1', invListQty = '$shoppingListQty', shoppingList = '0',
    shoppingListQty = '0'   WHERE inventoryId = $inventoryId";
  /*  $sql = "UPDATE $table SET what = '$what', brand = '$what', size = '$size', alert = '$alert',
    alertQty = '$alertQty', invList = '1', invListQty = '$shoppingListQty', shoppingList = '0',
    shoppingListQty = '0', notes = '$notes', userId = '$userId'  WHERE inventoryId = $inventoryId";*/
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
    // for($i = 0; $i <= $count; $i++){
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
   /* if ($cnxn->query($sql) === TRUE) {
        echo "success";
    }
    else {
        echo "error";
    }*/
    $cnxn->close();
    return;
}



?>