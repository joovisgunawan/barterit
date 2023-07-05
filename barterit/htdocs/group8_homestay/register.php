<?php
require 'dbconnect.php';
if ($_SERVER["REQUEST_METHOD"] == "POST") {
  // Retrieve form data
  $name = $_POST["name"];
  $email = $_POST["email"];
  $password = $_POST["password"];
  $confirmPassword = $_POST["confirmPassword"];

  // Validate form data (you can add more validation as needed)
  $errors = array();

  if (empty($name)) {
    $errors[] = "Name is required.";
  }

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

  if ($password !== $confirmPassword) {
    $errors[] = "Passwords do not match.";
  }

  // If there are no validation errors, you can perform further processing (e.g., store user in database)
  if (empty($errors)) {
    // Perform registration logic here

    // For demonstration purposes, we'll simply display a success message
    $createSQL = "INSERT into user(name,email,password) values('$name','$email','$password')";
    $result = mysqli_query($conn, $createSQL);
    $message = "Registration successful!";
  }
//   if($_SERVER['REQUEST_METHOD'] === 'POST'){
//     $name=$_POST['name'];
//     $age=$_POST['age'];
//     $course=$_POST['course'];
//     if(isset($_FILES['photo'])) {
//         $photo=$_FILES['photo'];
//         print_r( $photo);
//         echo pathinfo($photo['name'],PATHINFO_EXTENSION);
//         move_uploaded_file($photo['tmp_name'],'photo/' . $photo['name']);
//         $photopath='photo/' . $photo['name'];
//         }
//         else{
//             echo 'failed';
//         }
    
//     $update="UPDATE latihan1 SET name='$name', age='$age', course='$course', photo='$photopath' WHERE id=$id";
//     mysqli_query($conn, $update);
//     echo 'success';
// }
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <style>
    html,
    body {
      height: 100%;
    }

    .wrapper {
      min-height: 100%;
      display: flex;
      flex-direction: column;
    }

    .container {
      flex: 1;
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
  </style>
  <title>Registration Page</title>
</head>

<body>
  <div class="wrapper">
    <div class="wave-background"></div>

    <div class="container">
      <div class="row justify-content-center mt-5">
        <div class="col-md-6">
          <div class="card">
            <div class="card-header">
              <h4>Register</h4>
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

              <form method="POST" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
                <div class="mb-3">
                  <label for="name" class="form-label">Name</label>
                  <input type="text" class="form-control" id="name" name="name" placeholder="Enter your name">
                </div>
                <div class="mb-3">
                  <label for="email" class="form-label">Email</label>
                  <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email">
                </div>
                <div class="mb-3">
                  <label for="password" class="form-label">Password</label>
                  <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password">
                </div>
                <div class="mb-3">
                  <label for="confirmPassword" class="form-label">Confirm Password</label>
                  <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password">
                </div>
                <button type="submit" class="btn btn-primary">Register</button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>