<?php
    include_once 'dbconnect.php';
    if (!isset($_POST)) {
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
        die();
    }

    $id = $_POST['id'];

    $sql = "SELECT * FROM table_user WHERE user_id = '$id'";
    $result = $conn->query($sql);

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
    }else{
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
    }


    function sendJsonResponse($sentArray)
    {
        header('Content-Type: application/json');
        echo json_encode($sentArray);
    }
