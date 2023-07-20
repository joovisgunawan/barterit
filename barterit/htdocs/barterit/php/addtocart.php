<?php
include_once("dbconnect.php");
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

$product_id = $_POST['productId'];
$cart_quantity = $_POST['cartQuantity'];
$cart_price = $_POST['cartPrice'];
$buyer_id = $_POST['buyerId'];
$seller_id = $_POST['sellerId'];

$checkcatchid = "SELECT * FROM `table_cart` WHERE `buyer_id` = '$buyer_id' AND  `product_id` = '$product_id'";
$resultqty = $conn->query($checkcatchid);
$numresult = $resultqty->num_rows;
if ($numresult > 0) {
	$sql = "UPDATE `table_cart` SET `cart_quantity`= (cart_quantity + $cart_quantity),`cart_price`= (cart_price+$cart_price) WHERE `buyer_id` = '$buyer_id' AND  `product_id` = '$product_id'";
}else{
	// $sql = "INSERT INTO `table_cart`(`product_id`, `product_quantity`, `product_price`, `user_id`, `seller_id`) VALUES ('$product_id','$product_quantity','$product_price','$user_id','$seller_id')";
    $sql = "INSERT INTO `table_cart`(`product_id`,`buyer_id`, `seller_id`, cart_quantity, cart_price) VALUES ('$product_id','$buyer_id','$seller_id','$cart_quantity','$cart_price')";

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