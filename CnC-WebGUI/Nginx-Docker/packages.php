<!DOCTYPE html>
<html>
   <head>
    <style>
        .product-box {
            position: absolute;
            left: 25%;
            top: 10%;
            background: yellow;
        }
        .product-box2 {
            position: absolute;
            left: 2%;
            top: 20%;
            background: yellow;
        }
        .device-box1 {
            position: absolute;
            left: 25%;
            top: 15%;
        }
        .device-box2 {
            position: absolute;
            left: 25%;
            top: 20%;
        }
        .device-box3 {
            position: absolute;
            left: 25%;
            top: 25%;
        }
    </style>
   </head>
<body>


<?php
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

// Attempt select query execution
$sql = "SELECT * FROM packages";
if($result = mysqli_query($link, $sql)){
  if(mysqli_num_rows($result) > 0){
        echo '<div class="product-box2">';
        echo "<table align='left' cellspacing=3 cellpadding=4 border=1 bgcolor=dddddd>";
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
              echo "<td>" . $row['nettools'] . "</td>";
              echo "<td>" . $row['mysql'] . "</td>";
              echo "<td>" . $row['libpython'] . "</td>";
              echo "<td>" . $row['dockercecli'] . "</td>";
              echo "<td>" . $row['dockercomposeplugin'] . "</td>";
              echo "<td>" . $row['curl'] . "</td>";
              echo "<td>" . $row['containerd'] . "</td>";
          echo "</tr>";
      }
      echo "</table>";
      echo '</div>';
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