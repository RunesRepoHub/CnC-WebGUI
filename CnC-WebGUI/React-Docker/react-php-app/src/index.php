<!DOCTYPE html>
<html>
<body>

<?php
echo '<body style="background-color:#242323">';

// Include your PostgreSQL database configuration
include '/var/postgresql.php';

// Create a PostgreSQL connection
$conn = pg_connect("host=$servername port=5432 dbname=$dbname user=$username password=$password");

// Check the PostgreSQL connection
if (!$conn) {
  die("ERROR: Could not connect to the PostgreSQL database.");
}

echo "<center>";
echo '<span style="color:#ffffff;text-align:center;font-size:40px;">Overview</span>';
echo "</center>";
echo str_repeat('&nbsp;', 5);

// Attempt select query execution
$sql = "SELECT * FROM info";
$result = pg_query($conn, $sql);

if (!$result) {
  echo "ERROR: Could not execute the query.";
} else {
  $num_rows = pg_num_rows($result);

  if ($num_rows > 0) {
    echo "<center>";
    echo "<table align='center' cellspacing=3 cellpadding=4 border=1 bgcolor=dddddd>";
    echo "<tr>";
    echo "<th>Machine ID</th>";
    echo "<th>Hostname</th>";
    echo "<th>IP Address</th>";
    echo "<th>MAC Address</th>";
    echo "<th>Distro</th>";
    echo "<th>Package Updates</th>";
    echo "</tr>";

    while ($row = pg_fetch_assoc($result)) {
      echo "<tr>";
      echo "<td>" . $row['id'] . "</td>";
      echo "<td>" . $row['hostname'] . "</td>";
      echo "<td>" . $row['ipaddress'] . "</td>";
      echo "<td>" . $row['macaddress'] . "</td>";
      echo "<td>" . $row['distro'] . "</td>";
      echo "<td>" . $row['packages'] . "</td>";
      echo "</tr>";
    }

    echo "</table>";
    echo "</center>";
  } else {
    echo "No records matching your query were found.";
  }

  // Free result set
  pg_free_result($result);
}

// Close the PostgreSQL connection
pg_close($conn);
?>

</body>
</html>
