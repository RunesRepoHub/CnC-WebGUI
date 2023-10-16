import React, { useState, useEffect } from 'react';

function App() {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Fetch data from the PHP page
    fetch('/index.php') // Replace with the correct path
      .then((response) => response.json()) // Assuming the PHP script returns JSON
      .then((result) => {
        setData(result);
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
