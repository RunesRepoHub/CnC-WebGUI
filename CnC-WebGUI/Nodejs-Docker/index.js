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

app.post('/system-info/overview', async (req, res) => {
  const data = req.body;

  try {
    // Insert or update system overview information (using the IP as a unique identifier).
    await pool.query(
      `INSERT INTO overview (ip, mac, hostname, distro)
       VALUES ($1, $2, $3, $4)
       ON CONFLICT (ip) DO UPDATE
       SET mac = $2, hostname = $3, distro = $4`,
      [data.ip, data.mac, data.hostname, data.distro]
    );

    res.status(200).send('System overview data received and inserted or updated.');
  } catch (error) {
    console.error('Error:', error);
    res.status(500).send('An error occurred.');
  }
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
