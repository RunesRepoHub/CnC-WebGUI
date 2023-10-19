<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../style.css">
    <script>
        // Function to filter the table rows based on user input
        function searchTable() {
            var input, filter, table, tr, td, i, j, txtValue;
            input = document.getElementById("searchInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("packageTable");
            tr = table.getElementsByTagName("tr");

            for (i = 0; i < tr.length; i++) {
                tr[i].style.display = "none"; // Hide all rows by default
                td = tr[i].getElementsByTagName("td");
                for (j = 0; j < td.length; j++) {
                    txtValue = td[j].textContent || td[j].innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = ""; // Display the row if a match is found
                        break; // No need to check other columns in the same row
                    }
                }
            }
        }
    </script>
</head>
<body>
    <div class="overskift">
        <h1>Packages</h1>
        <a href="../Php/packages.php">Packages</a>
        <a href="../Php/cronjob.php">Cronjobs</a>
        <a href="../Php/overview.php">Overview</a>
    </div>
    <input type="text" id="searchInput" onkeyup="searchTable()" placeholder="Search for packages...">

    <table id="packageTable">
        <tr>
            <th>Hostname</th>
            <th>Package Name</th>
            <th>Status</th>
        </tr>
        <?php
        foreach ($packagesData as $row) {
            echo "<tr>";
            echo "<td>" . $row['hostname'] . "</td>";
            echo "<td>" . $row['packagename'] . "</td>";
            echo "<td>" . $row['installed'] . "</td>";
            echo "</tr>";
        }
        ?>
    </table>
</body>
</html>
