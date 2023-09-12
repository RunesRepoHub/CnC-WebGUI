<!DOCTYPE html>
<html>
<body>

<?php
$servername = "192.168.1.191";
$username = "root";
$password = "12Marvel";
$dbname = "machines";

// Create connection
$link = new mysqli($servername, $username, $password, $dbname);
// Check connection
if($link === false){
  die("ERROR: Could not connect. " . mysqli_connect_error());
}

// Attempt select query execution
$sql = "SELECT * FROM info WHERE hostname = 'Iron Man'";
if($result = mysqli_query($link, $sql)){
  if(mysqli_num_rows($result) > 0){
      echo "<table>";
          echo "<tr>";
              echo "<th>machine_id</th>";
              echo "<th>hostname</th>";
              echo "<th>ip_address</th>";
              echo "<th>mac_address</th>";
              echo "<th>disto</th>";
              echo "<th>packages</th>";
          echo "</tr>";
      while($row = mysqli_fetch_array($result)){
          echo "<tr>";
              echo "<td>" . $row['machine_id'] . "</td>";
              echo "<td>" . $row['hostname'] . "</td>";
              echo "<td>" . $row['ip_address'] . "</td>";
              echo "<td>" . $row['mac_address'] . "</td>";
              echo "<td>" . $row['disto'] . "</td>";
              echo "<td>" . $row['packages'] . "</td>";
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

// Attempt select query execution
$sql = "SELECT * FROM info LIMIT 50";
if($result = mysqli_query($link, $sql)){
  if(mysqli_num_rows($result) > 0){
      echo "<table>";
          echo "<tr>";
              echo "<th>hostname</th>";
              echo "<th>packages</th>";
          echo "</tr>";
      while($row = mysqli_fetch_array($result)){
          echo "<tr>";
              echo "<td>" . $row['hostname'] . "</td>";
              echo "<td>" . $row['packages'] . "</td>";
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