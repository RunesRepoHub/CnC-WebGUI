<?php
// API endpoint URL
$apiUrl = "http://cnc-api:3000/read/packages";

// Fetch data from the API
$data = file_get_contents($apiUrl);

// Check if the request was successful
if ($data === false) {
    die("Failed to fetch data from the API.");
}

// Parse the JSON data
$packagesData = json_decode($data, true);

// Check if the JSON was successfully parsed
if ($packagesData === null) {
    die("Failed to parse JSON data.");
}

?>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Packages</h1>
    <table>
        <tr>
            <th>Hostname</th>
            <th>git</th>
            <th>wget</th>
            <th>sudo</th>
            <th>python</th>
            <th>python3</th>
            <th>net-tools</th>
            <th>mysql</th>
            <th>libpython</th>
            <th>docker-ce-cli</th>
            <th>docker-compose-plugin</th>
            <th>curl</th>
            <th>containerd</th>
        </tr>
        <?php
        foreach ($packagesData as $row) {
            echo "<tr>";
            echo "<td>" . $row['hostname'] . "</td>";
            echo "<td>" . $row['git'] . "</td>";
            echo "<td>" . $row['wget'] . "</td>";
            echo "<td>" . $row['sudo'] . "</td>";
            echo "<td>" . $row['python'] . "</td>";
            echo "<td>" . $row['python3'] . "</td>";
            echo "<td>" . $row['nettools'] . "</td>";
            echo "<td>" . $row['mysql'] . "</td>";
            echo "<td>" . $row['libpython'] . "</td>";
            echo "<td>" . $row['dockercecli'] . "</td>";
            echo "<td>" . $row['dockercomposeplugin'] . "</td>";
            echo "<td>" . $row['curl'] . "</td>";
            echo "<td>" . $row['containerd'] . "</td>";
            echo "</tr>";
        }
        ?>
    </table>
</body>
</html>
