<?php
require 'dbconnect.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = $_POST['name'];
    $description = $_POST['description'];
    $price = $_POST['price'];
    $imagepath = $_POST['price'];
    // $image = $_POST['image'];
    if (isset($_FILES['image'])) {
        $image = $_FILES['image'];
        print_r($image);
        echo pathinfo($image['name'], PATHINFO_EXTENSION);
        move_uploaded_file($image['tmp_name'], 'image/' . $image['name']);
        $imagepath = 'image/' . $image['name'];
    }

    $query = "INSERT INTO homestay (name, description, price,image) VALUES ('$name', '$description', '$price','$imagepath')";
    $result = mysqli_query($conn, $query);

    if ($result) {
        echo "Homestay added successfully!";
    } else {
        echo "Error: " . mysqli_error($connection);
    }
}
?>

<!DOCTYPE html>
<html>

<head>
    <title>Homestay Booking - Add Homestay</title>
    <!-- Stylesheets and scripts -->
</head>

<body>
    <h1>Add Homestay</h1>

    <div class="container">
        <form method="POST" enctype="multipart/form-data">
            <div class="form-group">
                <label for="name">Homestay Name:</label>
                <input type="text" class="form-control" id="name" name="name" placeholder="Enter the homestay name" required>
            </div>
            <div class="form-group">
                <label for="description">Description:</label>
                <textarea class="form-control" id="description" name="description" placeholder="Enter the homestay description" required></textarea>
            </div>
            <div class="form-group">
                <label for="price">Price:</label>
                <input type="text" class="form-control" id="price" name="price" placeholder="Enter the homestay price" required>
            </div>
            <div class="form-group">
                <label for="image">Image URL:</label>
                <input type="file" class="form-control" id="image" name="image" placeholder="Enter the URL of the homestay image" required>
            </div>
            <button type="submit" class="btn btn-primary">Add Homestay</button>
        </form>
    </div>
</body>

</html>