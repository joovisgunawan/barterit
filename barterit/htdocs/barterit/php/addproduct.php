<?php
include_once("dbconnect.php");
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
$user_id = $_POST['userId'];
$product_name = $_POST['productName'];
$product_category = $_POST['productCategory'];
$product_description = $_POST['productDescription'];
$product_price = $_POST['productPrice'];
$product_quantity = $_POST['productQuantity'];
// $latitude = $_POST['latitude'];
// $longitude = $_POST['longitude'];
$product_state = $_POST['productState'];
$product_locality = $_POST['productLocality'];
$product_image = $_POST['productImage'];
// $status = "New";
$sql = "INSERT INTO table_product(user_id,product_name,product_category, product_description, product_price, product_quantity, product_state, product_locality) VALUES ('$user_id','$product_name','$product_category','$product_description','$product_price','$product_quantity','$product_state','$product_locality')";
// $result = $conn->query($sql);
// $number_of_result = $result->num_rows;


if ($conn->query($sql) === TRUE) {
    $filename = mysqli_insert_id($conn);
	$response = array('status' => 'success', 'data' => null);
	$decoded_string = base64_decode($product_image);//decode--make it image again
	$path = '../catches/'.$filename.'.png';//give image name and extension
	file_put_contents($path, $decoded_string);//move image to the path
    // $response = array('status' => 'success', 'data' => null);
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
