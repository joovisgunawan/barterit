<?php
include_once("dbconnect.php");
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
$cart_id = $_POST['cartId'];
$cart_quantity = $_POST['cartQuantity'];
$cart_price = $_POST['cartPrice'];

$sql = "UPDATE `table_cart` SET `cart_quantity`= $cart_quantity ,`cart_price`= $cart_price WHERE  `cart_id` = '$cart_id'";

if ($conn->query($sql) === TRUE) {
		$response = array('status' => 'success', 'data' => $sql);
		sendJsonResponse($response);
	}else{
		$response = array('status' => 'failed', 'data' => $sql);
		sendJsonResponse($response);
	}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>