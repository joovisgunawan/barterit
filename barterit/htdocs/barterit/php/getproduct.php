<?php
include_once("dbconnect.php");
if (!isset($_POST)) {
    $response = array('status' => 'failed1', 'data' => null);
    sendJsonResponse($response);
    die();
}


if (isset($_POST['current_page'])) {
    $currentPage = (int)$_POST['current_page'];
} else {
    $currentPage = 1;
}



// ex start from index 0
// start from index 10
// start from index 20


if (isset($_POST['user_id'])) {
    $userid = $_POST['user_id'];
    $sql = "SELECT * FROM `table_product` WHERE user_id = '$userid'";
} else if (isset($_POST['search_key'])) {
    $search = $_POST['search_key'];
    $sql = "SELECT * FROM `table_product` WHERE product_name LIKE '%$search%'";
} else if (isset($_POST['product_category'])) {
    $productCategory = $_POST['product_category'];
    $sql = "SELECT * FROM `table_product` WHERE product_category LIKE '%$productCategory%'";
    if ($_POST['product_category'] == 'For You') {
        $sql = "SELECT * FROM `table_product`";
    }
} else {
    $sql = "SELECT * FROM `table_product`";
}



$result = $conn->query($sql);
$totalResult = $result->num_rows;
$resultPerPage = 6;
$totalPage = ceil($totalResult / $resultPerPage);
$startingResultIndex = ($currentPage - 1) * $resultPerPage;
$sql = $sql . " LIMIT $startingResultIndex , $resultPerPage";
$result = $conn->query($sql);


if ($result->num_rows > 0) {
    $product["product"] = array();
    while ($row = $result->fetch_assoc()) {
        $productlist = array();
        $productlist['product_id'] = $row['product_id'];
        $productlist['user_id'] = $row['user_id'];
        $productlist['product_name'] = $row['product_name'];
        $productlist['product_category'] = $row['product_category'];
        $productlist['product_description'] = $row['product_description'];
        $productlist['product_price'] = $row['product_price'];
        $productlist['product_quantity'] = $row['product_quantity'];
        $productlist['product_state'] = $row['product_state'];
        $productlist['product_locality'] = $row['product_locality'];
        array_push($product["product"], $productlist);
    }
    $response = array('status' => 'success', 'totalPage' => $totalPage, 'data' =>  $product,);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed2', 'data' => null);
    sendJsonResponse($response);
}
function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
