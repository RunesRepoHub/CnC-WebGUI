<?php
// API endpoint URL
$apiUrl = "http://cnc-api:3000/read/cronjobs";

// Fetch data from the API
$data = file_get_contents($apiUrl);

// Check if the request was successful
if ($data === false) {
    die("Failed to fetch data from the API.");
}

// Parse the JSON data
$cronjobs = json_decode($data, true);

// Check if the JSON was successfully parsed
if ($cronjobs === null) {
    die("Failed to parse JSON data.");
}

// Display the data
echo "<h1>Cronjobs:</h1>";
echo "<ul>";
foreach ($cronjobs as $cronjob) {
    echo "<li>ID: " . $cronjob['id'] . "</li>";
    echo "<li>Hostname: " . $cronjob['hostname'] . "</li>";
    echo "<li>Cronjob Script: " . $cronjob['cronjobsscripts'] . "</li>";
    echo "<br>";
}
echo "</ul>";
?>
