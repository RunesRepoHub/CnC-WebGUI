// src/components/DataDisplay.js
import React, { useState, useEffect } from 'react';
import axios from 'axios';

function DataDisplay() {
  const [data, setData] = useState([]);

  useEffect(() => {
    axios.get('http://cnc-api:3000/read/cronjobs')
      .then(response => {
        setData(response.data);
      })
      .catch(error => {
        console.error('Error fetching data:', error);
      });
  }, []);

  return (
    <div>
      <h1>Data from API</h1>
      <ul>
        {data.map(item => (
          <li key={item.id}>
            <p>ID: {item.id}</p>
            <p>Hostname: {item.hostname}</p>
            <p>Cronjob Script: {item.cronjobsscripts}</p>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default DataDisplay;
