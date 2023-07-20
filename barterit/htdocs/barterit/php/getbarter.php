<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
//SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate FROM Orders INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID;


if (isset($_POST['buyerId'])) {
    $buyer_id = $_POST['buyerId'];
    $sql = "SELECT * FROM `table_barter` WHERE buyer_id = '$buyer_id'";
}

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $barteritems["barter"] = array();
    while ($row = $result->fetch_assoc()) {
        $barterlist = array();
        $barterlist['barter_id'] = $row['barter_id'];
        $barterlist['seller_product_id'] = $row['seller_product_id'];
        $barterlist['buyer_product_id'] = $row['buyer_product_id'];
        $barterlist['seller_id'] = $row['seller_id'];
        $barterlist['buyer_id'] = $row['buyer_id'];
        array_push($barteritems["barter"], $barterlist);
    }
    $response = array('status' => 'success', 'data' => $barteritems);
    sendJsonResponse($response);
}
 else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}
function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
