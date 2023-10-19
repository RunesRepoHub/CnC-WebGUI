<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../style.css">
    <script>
        function searchTable() {
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById('searchInput');
            filter = input.value.toUpperCase();
            table = document.getElementById('cronjobTable');
            tr = table.getElementsByTagName('tr');

            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName('td')[0]; // Change the index to match the column you want to search
                if (td) {
                    txtValue = td.textContent || td.innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = '';
                    } else {
                        tr[i].style.display = 'none';
                    }
                }
            }
        }
    </script>
</head>
<body>
  <div class="overskift">
    <h1>Cronjobs</h1>
    <a href="../Php/packages.php">Packages</a>
    <a href="../Php/cronjob.php">Cronjobs</a>
    <a href="../Php/overview.php">Overview</a>
  </div>
  <input type="text" id="searchInput" onkeyup="searchTable()" placeholder="Search for Hostname...">
    <table id="cronjobTable">
        <tr>
            <th>Hostname</th>
            <th>IP Address</th>
            <th>MAC Address</th>
            <th>Distro</th>
            <th>Package Updates</th>
        </tr>
        <?php foreach ($cronjobs as $cronjob): ?>
            <tr>
                <td><?php echo $cronjob['hostname']; ?></td>
                <td><?php echo $cronjob['ipaddress']; ?></td>
                <td><?php echo $cronjob['macaddress']; ?></td>
                <td><?php echo $cronjob['distro']; ?></td>
                <td><?php echo $cronjob['packages']; ?></td>
            </tr>
        <?php endforeach; ?>
    </table>
</body>
</html>
