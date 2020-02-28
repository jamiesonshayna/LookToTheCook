<?php
require ('/home/rwoodgre/connect2.php');


$servername = 'localhost';
$username = "rwoodgre_lookToCook";
$password = "NONEnone2@2@";
$dbname = "rwoodgre_lookToCook";
$table = "inventory";
// we will get actions from the app to do operations in the database...
$action = $_POST["action"];
$email = $_POST["email"];
/*// Create Connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check Connection
if($conn->connect_error){
    die("Connection Failed: " . $conn->connect_error);
    return;
}*/


// If connection is OK...
// $action = "GET_INV";
// Get all inventory records from the database
if("GET_INV" == $action){
    $db_data = array();
    $sql = "SELECT * from $table where invlist is true";
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
    $what = $_POST['what'];
    $brand = $_POST['brand'];
    $size = $_POST['size'];
    $alert = (bool)$_POST['alert']; // bool
    $alertQty = (int) $_POST['alertQty']; // int
    $invList = true; // bool
    $invListQty = (int) $_POST['invListQty']; // int
    $shoppingList = (bool)$_POST['shoppingList']; // bool
    $shoppingListQty = (int) $_POST['shoppingListQty']; // int
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

// Remember - this is the server file.
// I am updating the server file.
// Update an Item
if("UPDATE_INV" == $action){
    // App will be posting these values to this server

    $inventoryId = $_POST['inventoryId'];
    $what = $_POST['what'];
    $brand = $_POST['brand'];
    $size = $_POST['size'];
    $alert = (bool)$_POST['alert']; // bool
    $alertQty = (int) $_POST['alertQty']; // int
    $invList = (bool)$_POST['invList']; // bool
    $invListQty = (int) $_POST['invListQty']; // int
    $shoppingList = (bool)$_POST['shoppingList']; // bool
    $shoppingListQty = (int) $_POST['shoppingListQty']; // int
    $notes = $_POST['notes'];
    $userId = $_POST['userId'];

    $sql = "UPDATE $table SET what = '$what', brand = '$what', size = '$size', alert = '$alert', 
    alertQty = '$alertQty', invList = '$invList', invListQty = '$invListQty', shoppingList = '$shoppingList',
    shoppingListQty = '$shoppingListQty', notes = '$notes', userId = '$userId'  WHERE inventoryId = $inventoryId";
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


    $sql = "DELETE FROM $table WHERE inventoryId = $inventoryId"; // don't need quotes since id is an integer.
    if($cnxn->query($sql) === TRUE){
        echo "success";
    }else{
        echo "error";
    }
    $cnxn->close();
    return;
}

?>