<?php
// API endpoint URL
$apiUrl = "http://cnc-api:3000/read/info";

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

?>

<!DOCTYPE html>
<html>
<head>
    <style>
        body {
    font-family: Arial, sans-serif;
    color: #ffffff; /* Text color */
    background-color: #111111; /* Dark background color */
}

h1, h2, h3 {
    text-align: center;
    color: #ffffff;
}

table {
    width: 80%;
    border-collapse: collapse;
    margin: 20px auto;
    background-color: #333333; /* Dark background color for the table */
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

th, td {
    padding: 12px;
    text-align: left;
    border: 1px solid #555; /* Add border lines between cells */
}

th {
    background-color: #5e0000;
    font-weight: bold;
}

tr:nth-child(even) {
    background-color: #444444; /* Dark background color for even rows */
}


    </style>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
  <div class="overskift">
  <h1>Cronjobs</h1>
  <a href="../Php/packages.php">Packages</a>
  <a href="../Php/cronjob.php">Cronjobs</a>
  <a href="../Php/overview.php">Overview</a>
  </div>
    <table>
        <tr>
            <th>ID</th>
            <th>Hostname</th>
            <th>IP Address</th>
            <th>MAC Address</th>
            <th>Distro</th>
            <th>Package Updates</th>
        </tr>
        <?php foreach ($cronjobs as $cronjob): ?>
            <tr>
                <td><?php echo $cronjob['id']; ?></td>
                <td><?php echo $cronjob['hostname']; ?></td>
                <td><?php echo $cronjob['ipaddress']; ?></td>
                <td><?php echo $cronjob['macaddress']; ?></td>
                <td><?php echo $cronjob['distro']; ?></td>
                <td><?php echo $cronjob['packages']; ?></td>
            </tr>
        <?php endforeach; ?>
    </table>
</body>
</html>