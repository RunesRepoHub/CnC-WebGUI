const express = require('express');
const { Pool } = require('pg');

const app = express();
const port = 3000;

const pool = new Pool({
  user: 'root',
  host: 'cnc-db',
  database: 'machines',
  password: '12Marvel',
  port: 5432,
});

app.use(express.json());

// Reusable function to handle database operations
async function handleDatabaseOperation(query, values, res) {
  try {
    const { rows } = await pool.query(query, values);
    res.status(201).json(rows[0]);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
}

// Create a new item (Generic function for different tables)
app.post('/create/:table', (req, res) => {
  // ... (no change here)
});

app.post('/create/cronjobs', async (req, res) => {
  // ... (no change here)
});

// Get existing data based on hostname
app.get('/read/:table/:hostname', (req, res) => {
  // ... (no change here)
});

// ...

// Create or update data based on hostname (for packages table)
app.post('/packages/:hostname', (req, res) => {
  const { hostname } = req.params;
  const data = req.body;
  const query = `
    INSERT INTO packages (hostname, git, wget, sudo, python, python3, nettools, mysql, libpython, dockercecli, dockercomposeplugin, curl, containerd)
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)
    ON CONFLICT (hostname)
    DO UPDATE SET
    git = EXCLUDED.git,
    wget = EXCLUDED.wget,
    sudo = EXCLUDED.sudo,
    python = EXCLUDED.python,
    python3 = EXCLUDED.python3,
    nettools = EXCLUDED.nettools,
    mysql = EXCLUDED.mysql,
    libpython = EXCLUDED.libpython,
    dockercecli = EXCLUDED.dockercecli,
    dockercomposeplugin = EXCLUDED.dockercomposeplugin,
    curl = EXCLUDED.curl,
    containerd = EXCLUDED.containerd
    RETURNING *;
  `;
  const values = [
    hostname,
    data.git,
    data.wget,
    data.sudo,
    data.python,
    data.python3,
    data.nettools,
    data.mysql,
    data.libpython,
    data.dockercecli,
    data.dockercomposeplugin,
    data.curl,
    data.containerd,
  ];

  handleDatabaseOperation(query, values, res);
});

// ...


// Update data based on hostname (for info table)
app.put('/update/info/:hostname', (req, res) => {
  // ... (no change here, similar to packages)
});

// Update data based on hostname (for cronjobs table)
app.put('/update/cronjobs/:hostname', (req, res) => {
  // ... (no change here, similar to packages)
});

// Delete data based on hostname (for packages table)
app.delete('/delete/packages/:hostname', (req, res) => {
  const { hostname } = req.params;
  const query = 'DELETE FROM packages WHERE hostname = $1';

  handleDatabaseOperation(query, [hostname], res);
});

// Add similar delete routes for info and cronjobs tables if needed

app.listen(port, () => {
  console.log(`Node.js API is running on port ${port}`);
});
