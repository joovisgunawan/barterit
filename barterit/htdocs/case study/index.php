<!DOCTYPE html>
<html>
<head>
    <title>Homestay Booking System</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <header>
        <h1>Homestay Booking System</h1>
    </header>

    <section class="booking-form">
        <h2>Book a Homestay</h2>
        <form action="process_booking.php" method="POST">
            <label for="full_name">Full Name:</label>
            <input type="text" id="full_name" name="full_name" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="contact_number">Contact Number:</label>
            <input type="text" id="contact_number" name="contact_number" required>

            <label for="date_to_stay">Date to Stay:</label>
            <input type="date" id="date_to_stay" name="date_to_stay" required>

            <label for="num_nights">Number of Nights:</label>
            <input type="number" id="num_nights" name="num_nights" required>

            <label for="homestay">Choose a Homestay:</label>
            <select id="homestay" name="homestay" required>
                <option value="Homestay 1">Homestay 1</option>
                <option value="Homestay 2">Homestay 2</option>
                <option value="Homestay 3">Homestay 3</option>
            </select>

            <input type="submit" value="Book Now">
        </form>
    </section>

    <section class="booking-slider">
        <h2>Recent Bookings</h2>
        <div class="slider-container">
            <!-- This is where dynamically generated booking information will be displayed -->
        </div>
    </section>

    <footer>
        <p>Group Name - Members: [Member 1], [Member 2], [Member 3]</p>
    </footer>
</body>
</html>
