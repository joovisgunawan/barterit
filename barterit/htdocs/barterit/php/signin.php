<?php
    include_once 'dbconnect.php';
    if (!isset($_POST)) {
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
        die();
    }

    $email = $_POST['email'];
    $password = sha1($_POST['password']);

    $sql = "SELECT * FROM table_user WHERE user_email = '$email' AND user_password = '$password'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $userarray = array();
            $userarray['id'] = $row['user_id'];
            $userarray['name'] = $row['user_name'];
            $userarray['email'] = $row['user_email'];
            $userarray['password'] = $row['user_password'];
            $response = array('status' => 'success', 'data' => $userarray);
            sendJsonResponse($response);
        }
    }else{
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
    }


    function sendJsonResponse($sentArray)
    {
        header('Content-Type: application/json');
        echo json_encode($sentArray);
    }
