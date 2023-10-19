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
            <th>Packages</th>
        </tr>
        <?php
        foreach ($packagesData as $row) {
            echo "<tr>";
            echo "<td>" . $row['hostname'] . "</td>";
            echo "<td><ul>";
            foreach ($row['packages'] as $package => $version) {
                echo "<li><strong>$package:</strong> $version</li>";
            }
            echo "</ul></td>";
            echo "</tr>";
        }
        ?>
    </table>
</body>
</html>
