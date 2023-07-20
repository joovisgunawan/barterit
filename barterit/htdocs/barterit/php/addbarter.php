<?php
include_once("dbconnect.php");
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
$seller_id = $_POST['seller_id'];
$buyer_id = $_POST['buyer_id'];
$seller_product_id = $_POST['seller_product_id'];
$buyer_product_id = $_POST['buyer_product_id'];
$sql = "INSERT INTO table_barter(seller_id,buyer_id,seller_product_id, buyer_product_id) VALUES ('$seller_id','$buyer_id','$seller_product_id','$buyer_product_id')";


if ($conn->query($sql) === TRUE) {
    $filename = mysqli_insert_id($conn);
	$response = array('status' => 'success', 'data' => null);
    sendJsonResponse($response);
}else{
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}
function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
