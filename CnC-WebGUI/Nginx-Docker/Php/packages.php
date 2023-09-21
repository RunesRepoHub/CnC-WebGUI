<!DOCTYPE html>
<html>
<body>

<?php
echo '<body style="background-color:#242323">';

include '/var/mysql.php';

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
$sql = "SELECT * FROM packages";
if($result = mysqli_query($link, $sql)){
  if(mysqli_num_rows($result) > 0){
        echo "<table align='center' cellspacing=3 cellpadding=4 border=1 bgcolor=dddddd>";
          echo "<tr>";
              echo "<th>Hostname</th>";
              echo "<th>git</th>";
              echo "<th>wget</th>";
              echo "<th>sudo</th>";
              echo "<th>python</th>";
              echo "<th>python3</th>";
              echo "<th>net-tools</th>";
              echo "<th>mysql</th>";
              echo "<th>libpython</th>";
              echo "<th>docker-ce-cli</th>";
              echo "<th>docker-compose-plugin</th>";
              echo "<th>curl</th>";
              echo "<th>containerd</th>";
          echo "</tr>";
      while($row = mysqli_fetch_array($result)){
          echo "<tr>";
              echo "<td>" . $row['hostname'] . "</td>";
              echo "<td>" . $row['git'] . "</td>";
              echo "<td>" . $row['wget'] . "</td>";
              echo "<td>" . $row['sudo'] . "</td>";
              echo "<td>" . $row['python'] . "</td>";
              echo "<td>" . $row['python3'] . "</td>";
              echo "<td>" . $row['net_tools'] . "</td>";
              echo "<td>" . $row['mysql'] . "</td>";
              echo "<td>" . $row['libpython'] . "</td>";
              echo "<td>" . $row['docker_ce_cli'] . "</td>";
              echo "<td>" . $row['docker_compose_plugin'] . "</td>";
              echo "<td>" . $row['curl'] . "</td>";
              echo "<td>" . $row['containerd'] . "</td>";
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