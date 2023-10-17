import React, { useState, useEffect } from 'react';

function Overview() {
  const [cronjobData, setCronjobData] = useState([]);
  const [packagesData, setPackagesData] = useState([]);
  const [overviewData, setOverviewData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const cronjobsResponse = await fetch('http://cnc-api:3000/read/cronjobs');
        if (!cronjobsResponse.ok) {
          throw new Error('Failed to fetch cronjobs data');
        }
        const cronjobsData = await cronjobsResponse.json();
        setCronjobData(cronjobsData);

        const packagesResponse = await fetch('http://cnc-api:3000/read/packages');
        if (!packagesResponse.ok) {
          throw new Error('Failed to fetch packages data');
        }
        const packagesData = await packagesResponse.json();
        setPackagesData(packagesData);

        const overviewResponse = await fetch('http://cnc-api:3000/read/info');
        if (!overviewResponse.ok) {
          throw new Error('Failed to fetch overview data');
        }
        const overviewData = await overviewResponse.json();
        setOverviewData(overviewData);

        setLoading(false);
      } catch (error) {
        setError(error.message);
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  return (
    <div>
      {loading ? (
        <p>Loading data...</p>
      ) : (
        <>
          <h1>Cron Jobs</h1>
          <table>
            <thead>
              <tr>
                <th>Hostname</th>
                <th>Cron Jobs Scripts</th>
              </tr>
            </thead>
            <tbody>
              {cronjobData.map((item, index) => (
                <tr key={index}>
                  <td>{item.hostname}</td>
                  <td>{item.cronjobsscripts}</td>
                </tr>
              ))}
            </tbody>
          </table>

          <h1>Packages</h1>
          <table>
            <thead>
              <tr>
                <th>Hostname</th>
                <th>git</th>
                <th>wget</th>
                <th>sudo</th>
                <th>python</th>
                <th>python3</th>
                <th>net-tools</th>
                <th>mysql</th>
                <th>libpython</th>
                <th>docker-ce-cli</th>
                <th>docker-compose-plugin</th>
                <th>curl</th>
                <th>containerd</th>
              </tr>
            </thead>
            <tbody>
              {packagesData.map((item, index) => (
                <tr key={index}>
                  <td>{item.hostname}</td>
                  <td>{item.git}</td>
                  <td>{item.wget}</td>
                  <td>{item.sudo}</td>
                  <td>{item.python}</td>
                  <td>{item.python3}</td>
                  <td>{item.nettools}</td>
                  <td>{item.mysql}</td>
                  <td>{item.libpython}</td>
                  <td>{item.dockercecli}</td>
                  <td>{item.dockercomposeplugin}</td>
                  <td>{item.curl}</td>
                  <td>{item.containerd}</td>
                </tr>
              ))}
            </tbody>
          </table>

          <h1>Overview</h1>
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
              {overviewData.map((item, index) => (
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
        </>
      )}
    </div>
  );
}

export default Overview;
