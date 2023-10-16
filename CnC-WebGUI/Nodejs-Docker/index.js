  const express = require('express');
const { Pool } = require('pg');
const app = express();
const port = 3000;

const dbConfig = {
  user: 'root',
  host: 'cnc-db',
  database: 'machines',
  password: '12Marvel',
  port: 5432,
};

const pool = new Pool(dbConfig);

app.use(express.json());

app.post('/system-info', async (req, res) => {
  const data = req.body;

  try {
    switch (data.type) {
      case 'packages':
        // Check if the package exists in the 'packages' table.
        const packageExists = await pool.query('SELECT * FROM packages WHERE package_name = $1', [data.packageName]);
        if (packageExists.rows.length === 0) {
          // Insert if not found.
          await pool.query('INSERT INTO packages (package_name) VALUES ($1)', [data.packageName]);
        } else {
          // Update if found.
          await pool.query('UPDATE packages SET package_name = $1 WHERE package_name = $2', [data.packageName, data.packageName]);
        }
        break;
      case 'cronjobs':
        // Check if the cron job exists in the 'cronjobs' table (use a unique identifier).
        const cronjobExists = await pool.query('SELECT * FROM cronjobs WHERE job_id = $1', [data.jobId]);
        if (cronjobExists.rows.length === 0) {
          // Insert if not found.
          await pool.query('INSERT INTO cronjobs (job_id, job_description) VALUES ($1, $2)', [data.jobId, data.jobDescription]);
        } else {
          // Update if found.
          await pool.query('UPDATE cronjobs SET job_description = $2 WHERE job_id = $1', [data.jobId, data.jobDescription]);
        }
        break;
      case 'overview':
        // Insert or update system overview information (consider using a primary key like IP).
        await pool.query('INSERT INTO overview (ip, mac, hostname, distro) VALUES ($1, $2, $3, $4) ON CONFLICT (ip) DO UPDATE SET mac = $2, hostname = $3, distro = $4', [data.ip, data.mac, data.hostname, data.distro]);
        break;
      case 'usage':
        // Insert or update usage metrics (use a timestamp as a unique identifier).
        await pool.query('INSERT INTO usage (timestamp, cpu_usage, ram_usage, disk_usage) VALUES ($1, $2, $3, $4) ON CONFLICT (timestamp) DO UPDATE SET cpu_usage = $2, ram_usage = $3, disk_usage = $4', [data.timestamp, data.cpuUsage, data.ramUsage, data.diskUsage]);
        break;
      default:
        return res.status(400).send('Invalid data type.');
    }

    res.status(200).send('Data received and inserted or updated.');
  } catch (error) {
    console.error('Error:', error);
    res.status(500).send('An error occurred.');
  }
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
