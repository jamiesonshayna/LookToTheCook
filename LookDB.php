<?php

// this file lets us connect to the database
require('/home/rwoodgre/connect2.php');

// the table we want to access
$table = "inventory";
// we will get actions from the app to do operations in the database
$action = $_POST["action"];
// users email address
$email = $_POST["email"];

//$action = "GET_INV"; // for web testing
// Get all inventory records from the database
if ("GET_INV" == $action) {
    $db_data = array();
    $sql = "SELECT * from $table where invlist is true";
    $result = $cnxn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $db_data[] = $row;
        }
        // Send back the complete records as a json
        echo json_encode($db_data);
    } else {
        echo "error";
    }
    $cnxn->close();
    return;
}

// Add an Item
if ("ADD_INV" == $action) {
    // App will be posting these values to this server
    $what = $_POST['what'];
    $brand = $_POST['brand'];
    $size = $_POST['size'];
    $alert = (bool)$_POST['alert']; // bool
    $alertQty = (int)$_POST['alertQty']; // int
    $invList = true; // bool
    $invListQty = (int)$_POST['invListQty']; // int
    $shoppingList = (bool)$_POST['shoppingList']; // bool
    $shoppingListQty = (int)$_POST['shoppingListQty']; // int
    $notes = $_POST['notes'];

    $sql = "INSERT INTO $table (what, brand, size, alert, alertQty,
    invList, invListQty, shoppingList,
    shoppingListQty, notes)
     VALUES ( '$what', '$brand', '$size', '$alert', '$alertQty', '$invList', '$invListQty', '$shoppingList',
    '$shoppingListQty', '$notes')";
    $result = $cnxn->query($sql);
    echo "success";
    $cnxn->close();
    return;
}

// Update an Item

// re address this
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

    $sql = "UPDATE $table SET what = '$what', brand = '$what', size = '$size', alert = '$alert', 
    alertQty = '$alertQty', invList = '$invList', invListQty = '$invListQty', shoppingList = '$shoppingList',
    shoppingListQty = '$shoppingListQty', notes = '$notes', userId = '$userId'  WHERE inventoryId = $inventoryId";
    if ($cnxn->query($sql) === TRUE) {
        echo "success";
    } else {
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
    } else {
        echo "error";
    }
    $cnxn->close();
    return;
}


// Get all shopping records from the database
if ("GET_SHOP" == $action) {
    $db_data = array();
    $sql = "SELECT * from $table where shoppingList is true";
    $result = $cnxn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $db_data[] = $row;
        }
        // Send back the complete records as a json
        echo json_encode($db_data);
    } else {
        echo "error";
    }
    $cnxn->close();
    return;
}
// Add an Item
if ("ADD_SHOP" == $action) {
    // App will be posting these values to this server
    $what = $_POST['what'];
    $brand = $_POST['brand'];
    $size = $_POST['size'];
    $alert = (bool)$_POST['alert']; // bool
    $alertQty = (int)$_POST['alertQty']; // int
    $invList = false; // bool
    $invListQty = (int)$_POST['invListQty']; // int
    $shoppingList = true; // bool
    $shoppingListQty = (int)$_POST['shoppingListQty']; // int
    $notes = $_POST['notes'];

    $sql = "INSERT INTO $table (what, brand, size, alert, alertQty,
    invList, invListQty, shoppingList,
    shoppingListQty, notes)
     VALUES ( '$what', '$brand', '$size', '$alert', '$alertQty', '$invList', '$invListQty', '$shoppingList',
    '$shoppingListQty', '$notes')";
    $result = $cnxn->query($sql);
    echo "success";
    $cnxn->close();
    return;
}

/*require ('/home/rwoodgre/connect2.php');

// working with the table Inventory
$table = "inventory";

// we will get actions from the app to choose which operations to do in the database...
$action = $_POST["action"];

$action = "GET_INV"; //  for testing on web to make sure it gets the inventory
// components of the object aka Item
$inventoryId = $_POST['inventoryId'];
$what = $_POST['what'];
$brand = $_POST['brand'];
$size = $_POST['size'];
$alert = $_POST['alert'];
$alertQty = $_POST['alertQty'];
$invList = $_POST['invList'];
$invListQty = $_POST['invListQty'];
$shoppingList = $_POST['shoppingList'];
$shoppingListQty = $_POST['shoppingListQty'];
$notes = $_POST['notes'];
$userId = $_POST['userId'];

// If connection is OK...

// Get all inventory records from the database
if("GET_INV" == $action){
    $db_data = array();
    $sql = "SELECT * from $table";
    $result = $cnxn->query($sql);
    if($result->num_rows > 0){
        while($row = $result->fetch_assoc()){
            $db_data[] = $row;
        }
        // Send back the complete records as a json
        echo json_encode($db_data);
    }
    else{
        echo "error";
    }
    $cnxn->close();
    return;
}

// Add an Item
if("ADD_INV" == $action){
    // App will be posting these values to this server

    $sql = "INSERT INTO $table (what, brand, size, alert, alertQty,
    invList, invListQty, shoppingList,
    shoppingListQty, notes, userId)
     VALUES (
    $what, $brand, $size, $alert, $alertQty,
    '$invList, $invListQty, $shoppingList,
    '$shoppingListQty', '$notes', '$userId')";
    $result = $cnxn->query($sql);
    echo "success";
    $cnxn->close();
    return;
}

// Remember - this is the server file.
// I am updating the server file.
// Update an Item
if("UPDATE_INV" == $action){
    // App will be posting these values to this server

    $sql = "UPDATE $table SET what = '$what', brand = '$what', size = '$size', alert = '$alert', 
    alertQty = '$alertQty', invList = '$invList', invListQty = '$invListQty', shoppingList = '$shoppingList',
    shoppingListQty, notes, userId WHERE inventoryId = $inventoryId";
    if($cnxn->query($sql) === TRUE){
        echo "success";
    }else{
        echo "error";
    }
    $cnxn->close();
    return;
}

// Delete an item
if('DELETE_INV' == $action){
    $inventoryId = $_POST['inventoryId'];

    $sql = "DELETE FROM $table WHERE id = $inventoryId"; // don't need quotes since id is an integer.
    if($cnxn->query($sql) === TRUE){
        echo "success";
    }else{
        echo "error";
    }
    $cnxn->close();
    return;
}

*/?>