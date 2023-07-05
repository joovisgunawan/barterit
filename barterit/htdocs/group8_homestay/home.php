<?php
require 'dbconnect.php';
session_start(); // Start the session

// Check if the user is logged in
if (!isset($_SESSION['email'])) {
    // If not logged in, redirect to the login page or display an error message
    header("Location: login.php");
    exit;
}

// The user is logged in, so you can access their email from the session variable
$email = $_SESSION['email'];
$sql = "SELECT * FROM homestay";
$result = mysqli_query($conn, $sql);

if (isset($_GET['logout'])) {
    session_destroy();
    header("Location: login.php");
    exit;
}
?>
<!DOCTYPE html>
<html>

<head>
    <title>Homestay Booking</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        h1 {
            text-align: center;
        }

        .homestay-card {
            margin-bottom: 20px;
            border: 1px solid #ccc;
        }

        .homestay-card .card-body {
            height: 300px;
        }

        .homestay-name {
            font-weight: bold;
            font-size: 20px;
        }

        .homestay-description {
            margin-top: 5px;
            color: #888;
            display: -webkit-box;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
            -webkit-line-clamp: 3;
            /* Limit the text to 3 lines */
        }

        .homestay-price {
            font-weight: bold;
            font-size: 18px;
        }

        .homestay-image {
            max-width: 100%;
            height: auto;
            margin-bottom: 10px;
        }

        .book-button {
            background-color: #4CAF50;
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            cursor: pointer;
        }

        .search-form {
            margin-bottom: 20px;
        }
    </style>
</head>

<body>
    <header class="p-3 mb-3 border-bottom">
        <div class="container">
            <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
                <a href="/" class="d-flex align-items-center mb-2 mb-lg-0 link-body-emphasis text-decoration-none">
                    <svg class="bi me-2" width="40" height="32" role="img" aria-label="Bootstrap">
                        <use xlink:href="#bootstrap" />
                    </svg>
                </a>

                <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                    <li><a href="#" class="nav-link px-2 link-secondary">Home</a></li>
                    <li><a href="book.php" class="nav-link px-2 link-body-emphasis">Dashboard</a></li>
                    <li><a href="book.php" class="nav-link px-2 link-body-emphasis">Orders</a></li>
                    <li><a href="book.php" class="nav-link px-2 link-body-emphasis">Products</a></li>
                </ul>

                <!-- <form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" role="search">
          <input type="search" class="form-control" placeholder="Search..." aria-label="Search">
        </form> -->

                <div class="dropdown text-end">
                    <a href="#" class="d-block link-body-emphasis text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="https://picsum.photos/20" alt="mdo" width="32" height="32" class="rounded-circle">
                    </a>
                    <ul class="dropdown-menu text-small">
                        <li><a class="dropdown-item" href="#">New project...</a></li>
                        <li><a class="dropdown-item" href="#">Settings</a></li>
                        <li><a class="dropdown-item" href="#">Profile</a></li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li><a class="dropdown-item" href="?logout=true">Sign out</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </header>
    <h1>Homestay Booking</h1>
    <h2>Welcom <?= $email ?></h2>

    <div class="container">
        <form class="search-form">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Search by name...">
                <button type="submit" class="btn btn-primary">Search</button>
            </div>
        </form>


        <div class="row">
            <?php
            while ($row = mysqli_fetch_array($result)) {
            ?>
                <div class="col-md-3">
                    <div class="card homestay-card">
                        <img src="<?= $row['image'] ?>" alt="<?php echo $row['name']; ?>" class="homestay-image">
                        <div class="card-body">
                            <h5 class="card-title homestay-name"><?= $row['name'] ?></h5>
                            <p class="card-text homestay-description"><?= $row['description'] ?></p>
                            <p class="card-text homestay-price"><?= $row['price'] ?></p>
                            <a href="book.php" class="btn btn-success book-button">Book Now</a>
                        </div>
                    </div>
                </div>
            <?php
            }
            ?>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>