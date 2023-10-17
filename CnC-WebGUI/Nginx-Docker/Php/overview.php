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
            background-color: #242323;
            font-family: Arial, sans-serif;
        }

        h1 {
            text-align: center;
            color: #333;
        }

        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px auto;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

    </style>
</head>
<body>
    <h1>Cronjobs</h1>
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