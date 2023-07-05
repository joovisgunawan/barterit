<?php
include_once("dbconnect.php");
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

$product_id = $_POST['productId'];
$product_quantity = $_POST['product_quantity'];
$product_price = $_POST['product_price'];
$user_id = $_POST['userId'];
$seller_id = $_POST['sellerId'];

$checkcatchid = "SELECT * FROM `table_cart` WHERE `user_id` = '$user_id' AND  `product_id` = '$product_id'";
$resultqty = $conn->query($checkcatchid);
$numresult = $resultqty->num_rows;
if ($numresult > 0) {
	$sql = "UPDATE `table_cart` SET `product_quantity`= (product_quantity + $product_quantity),`product_price`= (product_price+$product_price) WHERE `user_id` = '$user_id' AND  `product_id` = '$product_id'";
}else{
	// $sql = "INSERT INTO `table_cart`(`product_id`, `product_quantity`, `product_price`, `user_id`, `seller_id`) VALUES ('$product_id','$product_quantity','$product_price','$user_id','$seller_id')";
    $sql = "INSERT INTO `table_cart`(`product_id`,`user_id`, `seller_id`) VALUES ('$product_id','$user_id','$seller_id')";

}

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