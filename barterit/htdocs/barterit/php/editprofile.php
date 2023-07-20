<?php
include_once 'dbconnect.php';
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

$id = $_POST['id'];
$name = $_POST['name'];
$password = sha1($_POST['password']);
$gender = $_POST['gender'];
$phone = $_POST['phone'];
$address = $_POST['address'];
$user_photo = $_POST['photo'];
$decoded_string = base64_decode($user_photo); //decode--make it image again
$path = '../photo/' . $id  . '.png'; //give image name and extension
file_put_contents($path, $decoded_string); //move image to the path
$sql = "UPDATE `table_user` SET `user_name`='$name',`user_password`='$password',`user_gender`='$gender',`user_phone`='$phone',`user_address`='$address', `user_photo`='$id' WHERE `user_id`='$id'";
$result = $conn->query($sql);
if ($conn->query($sql) === TRUE) {
    $getsql = "SELECT * FROM table_user WHERE user_id = '$id'";
    $result = $conn->query($getsql);

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $userarray = array();
            $userarray['id'] = $row['user_id'];
            $userarray['name'] = $row['user_name'];
            $userarray['email'] = $row['user_email'];
            $userarray['password'] = $row['user_password'];
            $userarray['gender'] = $row['user_gender'];
            $userarray['phone'] = $row['user_phone'];
            $userarray['address'] = $row['user_address'];
            $userarray['photo'] = $row['user_photo'];
            $response = array('status' => 'success', 'data' => $userarray);
            sendJsonResponse($response);
        }
    }
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}
function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
