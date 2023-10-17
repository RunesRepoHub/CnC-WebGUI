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
}

th, td {
    padding: 12px;
    text-align: left;
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
  <h1>Packages</h1>
  <a href="../Php/packages.php">Packages</a>
  <a href="../Php/cronjob.php">Cronjobs</a>
  <a href="../Php/overview.php">Overview</a>
  </div>
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
