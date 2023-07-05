<?php
    include_once 'dbconnect.php';
    if (!isset($_POST)) {
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
        die();
    }

    $name=$_POST['name'];
    $email=$_POST['email'];
    $password=sha1($_POST['password']);
    
    $sql="INSERT INTO table_user (user_name, user_email, user_password) VALUES('$name','$email','$password')";
    if ($conn->query($sql) === TRUE) {
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
?>