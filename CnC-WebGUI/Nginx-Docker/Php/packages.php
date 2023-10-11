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
echo '<span style="color:#ffffff;text-align:center;font-size:40px;">Package Updates</span>';
echo "</center>";
echo str_repeat('&nbsp;', 5);

// Attempt a select query execution
$sql = "SELECT * FROM packages";
$result = pg_query($conn, $sql);

if (!$result) {
  echo "ERROR: Could not execute the query.";
} else {
  $num_rows = pg_num_rows($result);

  if ($num_rows > 0) {
    echo "<table align='center' cellspacing=3 cellpadding=4 border=1 bgcolor=dddddd>";
    echo "<tr>";
    echo "<th>Hostname</th>";
    echo "<th>git</th>";
    echo "<th>wget</th>";
    echo "<th>sudo</th>";
    echo "<th>python</th>";
    echo "<th>python3</th>";
    echo "<th>net-tools</th>";
    echo "<th>postgresql</th>";
    echo "<th>libpython</th>";
    echo "<th>docker-ce-cli</th>";
    echo "<th>docker-compose-plugin</th>";
    echo "<th>curl</th>";
    echo "<th>containerd</th>";
    echo "</tr>";

    while ($row = pg_fetch_assoc($result)) {
      echo "<tr>";
      echo "<td>" . $row['hostname'] . "</td>";
      echo "<td>" . $row['git'] . "</td>";
      echo "<td>" . $row['wget'] . "</td>";
      echo "<td>" . $row['sudo'] . "</td>";
      echo "<td>" . $row['python'] . "</td>";
      echo "<td>" . $row['python3'] . "</td>";
      echo "<td>" . $row['nettools'] . "</td>";
      echo "<td>" . $row['postgresql'] . "</td>";
      echo "<td>" . $row['libpython'] . "</td>";
      echo "<td>" . $row['dockercecli'] . "</td>";
      echo "<td>" . $row['dockercomposeplugin'] . "</td>";
      echo "<td>" . $row['curl'] . "</td>";
      echo "<td>" . $row['containerd'] . "</td>";
      echo "</tr>";
    }

    echo "</table>";
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
