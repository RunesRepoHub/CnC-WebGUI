import React, { useState, useEffect } from 'react';

function App() {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Fetch data from the PHP page using the `fetch` API
    fetch('/index.php')
      .then((response) => response.text())
      .then((html) => {
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, 'text/html');

        const rows = doc.querySelectorAll('table tr');
        const rowData = [];

        rows.forEach((row) => {
          const columns = row.querySelectorAll('td');
          if (columns.length === 6) {
            const rowDataItem = {
              id: columns[0].textContent,
              hostname: columns[1].textContent,
              ipaddress: columns[2].textContent,
              macaddress: columns[3].textContent,
              distro: columns[4].textContent,
              packages: columns[5].textContent,
            };
            rowData.push(rowDataItem);
          }
        });

        setData(rowData);
        setLoading(false);
      })
      .catch((error) => {
        console.error('Error fetching data:', error);
        setLoading(false);
      });
  }, []);

  return (
    <div className="App">
      <h1>Overview</h1>
      {loading ? (
        <p>Loading data...</p>
      ) : (
        <table>
          <thead>
            <tr>
              <th>Machine ID</th>
              <th>Hostname</th>
              <th>IP Address</th>
              <th>MAC Address</th>
              <th>Distro</th>
              <th>Package Updates</th>
            </tr>
          </thead>
          <tbody>
            {data.map((item, index) => (
              <tr key={index}>
                <td>{item.id}</td>
                <td>{item.hostname}</td>
                <td>{item.ipaddress}</td>
                <td>{item.macaddress}</td>
                <td>{item.distro}</td>
                <td>{item.packages}</td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
}

export default App;
