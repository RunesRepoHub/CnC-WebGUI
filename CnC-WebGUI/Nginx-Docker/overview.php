<!DOCTYPE html>
<html>
   <head>
    <style>
        .product-box {
            position: absolute;
            left: 25%;
            top: 10%;
            margin: 0 auto
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
echo '<body style="background-color:#242323">';
echo "<center>";
echo '<span style="color:#ffffff;text-align:center;font-size:40px;">Overview</span>';
echo "</center>";

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
$sql = "SELECT * FROM info";
if($result = mysqli_query($link, $sql)){
  if(mysqli_num_rows($result) > 0){
        echo '<div class="product-box">';
        echo "<table align='left' cellspacing=3 cellpadding=4 border=1 bgcolor=dddddd>";
          echo "<tr>";
              echo "<th>Machine ID</th>";
              echo "<th>Hostname</th>";
              echo "<th>IP Address</th>";
              echo "<th>MAC Address</th>";
              echo "<th>Disto</th>";
              echo "<th>Package Updates</th>";
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