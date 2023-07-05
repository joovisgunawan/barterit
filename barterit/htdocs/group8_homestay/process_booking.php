<?php
// Retrieve form data
$full_name = $_POST['full_name'];
$email = $_POST['email'];
$contact_number = $_POST['contact_number'];
$date_to_stay = $_POST['date_to_stay'];
$num_nights = $_POST['num_nights'];
$homestay = $_POST['homestay'];

// Establish a database connection (replace with your own credentials)
require 'dbconnect.php';


// Prepare the SQL statement
$stmt = $conn->prepare("INSERT INTO bookings (full_name, email, contact_number, date_to_stay, num_nights, homestay) VALUES ('$full_name', '$email', '$contact_number', '$date_to_stay', '$num_nights', '$homestay')");

// Bind parameters

// Execute the SQL statement
if ($stmt->execute()) {
    // Booking added successfully
    // Redirect to a thank you page or any other desired page
    header("Location: home.php");
    exit();
} else {
    // Failed to add booking
    echo "Error adding booking.";
}
?>
