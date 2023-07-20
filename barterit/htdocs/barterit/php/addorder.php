<?php
include_once("dbconnect.php");
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

$sql = "INSERT INTO table_order(seller_id,buyer_id, product_id) VALUES ('$seller_id','$buyer_id','$product_id')";


function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>