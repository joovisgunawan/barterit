<?php
require 'dbconnect.php';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = $_POST['name'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $createSQL = "INSERT into user(name,email,password) values('$name','$email','$password')";
    $result=mysqli_query($conn,$createSQL);
}
?>
<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <style>
        .main {
            background-image: url("https://picsum.photos/1920/1080");
            min-height: 100vh;
        }

        .navbar-scrolled {
            background-color: white !important;
        }
        #formcontainer {
        position: relative;
        backdrop-filter: blur(5px);
        background-color: rgba(255, 255, 255, 0.7);
        border-radius: 8px;
    }
    </style>
    <script>
        window.addEventListener('scroll', function () {
            var navbar = document.querySelector('.navbar');
            navbar.classList.toggle('navbar-scrolled', window.scrollY > 0);
        });
    </script>
</head>
<body>
<nav class="navbar fixed-top navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Navbar</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Link</a>
        </li>
        <!-- <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Dropdown
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">Action</a></li>
            <li><a class="dropdown-item" href="#">Another action</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">Something else here</a></li>
          </ul>
        </li> -->
        <li class="nav-item">
          <a class="nav-link disabled">Disabled</a>
        </li>
      </ul>

        <button class="btn btn-outline-success" type="submit">Search</button>

    </div>
  </div>
</nav>
    <div class="main d-flex align-items-center" >
        <div class="container p-4" style="width:500px; background-color:white; border-radius:8px;" id="formcontainer">
        <!-- <img class="mb-4" src="https://picsum.photos/64/64" alt="" width="72" height="57"> -->
    <h1 class="h3 mb-3 fw-normal">Register</h1>
            <form action="" method="post">
                <div class="mb-3">
                    <label for="name" class="form-label">Name</label>
                    <input type="text" class="form-control" id="name" name="name"
                        placeholder="name@example.com">
                </div>
                <div class="mb-3">
                    <label for="exampleFormControlInput1" class="form-label">Email</label>
                    <input type="text" class="form-control" id="email" name="email"
                        placeholder="name@example.com">
                </div>
                <div class="mb-3">
                    <label for="exampleFormControlInput1" class="form-label">Password</label>
                    <input type="text" class="form-control" id="password" name="password"
                        placeholder="name@example.com">
                </div>
                <div class="mb-3">
                    <label for="exampleFormControlInput1" class="form-label">reconfirm Password</label>
                    <input type="text" class="form-control" id="exampleFormControlInput1"
                        placeholder="name@example.com">
                </div>
                <button class="btn btn-outline-success" type="submit">Submit</button>
            </form>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</body>

</html>