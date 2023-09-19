<!DOCTYPE html>
<html>
<body>

<?php
echo '<body style="background-color:#242323">';

$servername = "cnc-webgui-db";
$username = "root";
$password = "12Marvel";
$dbname = "machines";

// Create connection
$link = new mysqli($servername, $username, $password, $dbname);
// Check connection
if($link === false){
  die("ERROR: Could not connect. " . mysqli_connect_error());
}

echo "<center>";
echo '<span style="color:#ffffff;text-align:center;font-size:40px;">Package Updates</span>';
echo "</center>";
echo str_repeat('&nbsp;', 5);

// Attempt select query execution
$sql = "SELECT * FROM packages ORDER BY package ASC";
if($result = mysqli_query($link, $sql)){
  if(mysqli_num_rows($result) > 0){
        echo "<table align='center' cellspacing=3 cellpadding=4 border=1 bgcolor=dddddd>";
          echo "<tr>";
              echo "<th>Hostname</th>";
              echo "<th>Package</th>";
              echo "<th>Package Version</th>";
          echo "</tr>";
      while($row = mysqli_fetch_array($result)){
          echo "<tr>";
              echo "<td>" . $row['hostname'] . "</td>";
              echo "<td>" . $row['package'] . "</td>";
              echo "<td>" . $row['package_version'] . "</td>";
          echo "</tr>";
      }
      echo "</table>";
      // Free result set
      mysqli_free_result($result);
  } else{
      echo "No records matching your query were found.";
  }
} else{
  echo "ERROR: Could not able to execute $sql. " . mysqli_error($link);
}


// Close connection
mysqli_close($link);
?>


</body>
</html>