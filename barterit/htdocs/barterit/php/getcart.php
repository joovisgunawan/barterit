<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
//SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate FROM Orders INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID;


if (isset($_POST['userid'])) {
    $userid = $_POST['userid'];
    $sqlcart = "SELECT * FROM `table_cart` INNER JOIN `table_product` ON table_cart.product_id = table_product.product_id WHERE table_cart.user_id = '$userid'";
}

$result = $conn->query($sqlcart);
if ($result->num_rows > 0) {
    $cartitems["cart"] = array();
    while ($row = $result->fetch_assoc()) {
        $cartlist = array();
        $cartlist['cart_id'] = $row['cart_id'];
        $cartlist['product_id'] = $row['product_id'];
        $cartlist['product_name'] = $row['product_name'];
        // $cartlist['product_status'] = $row['product_status'];
        $cartlist['product_category'] = $row['product_category'];
        $cartlist['product_description'] = $row['product_description'];
        $cartlist['product_quantity'] = $row['product_quantity'];
        $cartlist['product_price'] = $row['product_price'];
        $cartlist['user_id'] = $row['user_id'];
        $cartlist['seller_id'] = $row['seller_id'];
        // $cartlist['cart_date'] = $row['cart_date'];
        array_push($cartitems["cart"], $cartlist);
    }
    $response = array('status' => 'success', 'data' => $cartitems);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}
function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
