<?php
    $dbhost = "localhost";
    $dbuser = "root";
    $dbpass = "";
    $db = "barterit";

    $conn = new mysqli($dbhost, $dbuser, $dbpass, $db);
    if(!$conn){
        die("Connection failed: " . $conn->connect_error);
    }
?>