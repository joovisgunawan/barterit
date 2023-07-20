<?php
    // $dbhost = "sql6.freemysqlhosting.net";
    // $dbuser = "sql6634026";
    // $dbpass = "CYqlmARmfT";
    // $db = "sql6634026";
    $dbhost = "localhost";
    $dbuser = "root";
    $dbpass = "";
    $db = "barterit";

    $conn = new mysqli($dbhost, $dbuser, $dbpass, $db);
    if(!$conn){
        die("Connection failed: " . $conn->connect_error);
    }
?>