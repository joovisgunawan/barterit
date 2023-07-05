<?php
require 'dbconnect.php';
session_start();
if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $email = $_POST["email"];
  $password = $_POST["password"];
  $errors = array();

  if (empty($email)) {
    $errors[] = "Email is required.";
  } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    $errors[] = "Invalid email format.";
  }

  if (empty($password)) {
    $errors[] = "Password is required.";
  } else {
    if (strlen($password) < 6) {
      $errors[] = "Password must be at least 6 characters long.";
    }
    if (!preg_match("/[A-Z]/", $password)) {
      $errors[] = "Password must contain at least one uppercase letter.";
    }
    if (!preg_match("/[!@#$%^&*()\-_=+{};:,<.>]/", $password)) {
      $errors[] = "Password must contain at least one special character.";
    }
  }

  $sql = "SELECT * FROM user WHERE email='$email'";
  $result = mysqli_query($conn, $sql);
  if ($result->num_rows > 0) {
    $row = mysqli_fetch_assoc($result);
    // $new = $row['email'];
    $new1 = $row['password'];
    if ($password == $new1) {
      $message = "Registration successful!";
      $_SESSION['email'] = $row['email'];
      echo "<script>alert('Login Successful')</script>";
      // header("Location: home.php");
      // exit;
      // header("Location: home.php");
    }
  } else {
    // echo "<script>alert('Login Successful')</script>";
    $error = "Invalid email or password";
  }
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <style>
    body {
      position: relative;
      min-height: 100vh;
    }

    .wave-background {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-image: url('wave.svg');
      background-repeat: no-repeat;
      background-size: cover;
      background-position: center;
    }

    .container {
      position: relative;
      z-index: 1;
      padding-top: 100px;
    }

    .card {
      border: none;
      border-radius: 10px;
      box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
    }

    .card-header {
      background-color: #f8f9fa;
      border-bottom: none;
      text-align: center;
      padding: 20px;
    }

    .card-body {
      padding: 30px;
    }

    .btn-primary {
      background-color: #007bff;
      border-color: #007bff;
    }

    .btn-primary:hover {
      background-color: #0069d9;
      border-color: #0062cc;
    }
  </style>
  <title>Login Page</title>
</head>

<body>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">
      <a class="navbar-brand" href="#">Logo</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="home.php">Sign up</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="wave-background"></div>

  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-4">
        <div class="card">
          <div class="card-header">
            <h4>Login</h4>
          </div>
          <div class="card-body">
          <?php if (isset($message)) : ?>
                <div class="alert alert-success" role="alert">
                  <?php echo $message; ?>
                </div>
              <?php endif; ?>

              <?php if (!empty($errors)) : ?>
                <div class="alert alert-danger" role="alert">
                  <ul>
                    <?php foreach ($errors as $error) : ?>
                      <li><?php echo $error; ?></li>
                    <?php endforeach; ?>
                  </ul>
                </div>
              <?php endif; ?>
            <form method="post">
              <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="text" class="form-control" id="email" name="email" placeholder="Enter your email">
              </div>
              <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password">
              </div>
              <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary">Login</button>
              </div>
            </form>
          </div>
          <div class="card-footer">
            <p class="text-center">Don't have an account yet? <a href="register.php">Sign up</a></p>
            <p class="text-center"><a href="forgot-password.php">Forgot Password?</a></p>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>