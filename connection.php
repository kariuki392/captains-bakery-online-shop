<?php
    // Enable error reporting
    error_reporting(E_ALL);
    ini_set('display_errors', 1);

    try {
        // Test connection without selecting database first
        $database = new mysqli("localhost", "root", "");
        if ($database->connect_error) {
            die("Connection failed: " . $database->connect_error);
        }

        // Try to select the database
        if (!$database->select_db("captains_dough")) {
            die("Database selection failed: " . $database->error);
        }

        echo "Connected successfully"; // This line is just for testing
    } catch (mysqli_sql_exception $e) {
        die("Database error: " . $e->getMessage());
    }
    $servername = "localhost";
    $username = "root";  // your database username
    $password = "";      // your database password
    $dbname = "captains_dough";
    
    // Create connection
    $database = new mysqli($servername, $username, $password, $dbname);
    
    // Check connection
    if ($database->connect_error) {
        die("Connection failed: " . $database->connect_error);
    }
?>