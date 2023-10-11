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

// Create a new item
app.post('/cronjob', async (req, res) => {
  const { hostname, cronjobsscripts } = req.body; // Updated variable names

  // Check if 'hostname' is provided in the request body
  if (!hostname) {
    return res.status(400).json({ error: 'Missing hostname in request body' });
  }

  const query = 'INSERT INTO cronjobs (hostname, cronjobsscripts) VALUES ($1, $2) RETURNING *';

  try {
    const { rows } = await pool.query(query, [hostname, cronjobsscripts]);
    res.status(201).json(rows[0]);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Retrieve all items
app.get('/cronjob', async (req, res) => {
  try {
    const { rows } = await pool.query('SELECT * FROM cronjobs');
    res.json(rows);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Update an item
app.put('/cronjob/:id', async (req, res) => {
  const { id } = req.params;
  const { hostname, cronjobsscripts } = req.body;
  const query = 'UPDATE cronjob SET hostname = $1, cronjobsscripts = $2 WHERE id = $3 RETURNING *';

  try {
    const { rows } = await pool.query(query, [hostname, cronjobsscripts, id]);
    res.json(rows[0]);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Delete an item
app.delete('/cronjob/:id', async (req, res) => {
  const { id } = req.params;
  const query = 'DELETE FROM cronjob WHERE id = $1';

  try {
    await pool.query(query, [id]);
    res.sendStatus(204);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Create a new item
app.post('/info', async (req, res) => {
  const { hostname, ipaddress, macaddress, disto, packages  } = req.body; // Updated variable names

  // Check if 'hostname' is provided in the request body
  if (!hostname) {
    return res.status(400).json({ error: 'Missing hostname in request body' });
  }

  const query = 'INSERT INTO info (hostname, ipaddress, macaddress, disto, packages) VALUES ($1, $2, $3, $4, $5) RETURNING *';

  try {
    const { rows } = await pool.query(query, [hostname, ipaddress, macaddress, disto, packages]);
    res.status(201).json(rows[0]);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Retrieve all items
app.get('/info', async (req, res) => {
  try {
    const { rows } = await pool.query('SELECT * FROM info');
    res.json(rows);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Update an item
app.put('/info/:id', async (req, res) => {
  const { id } = req.params;
  const { hostname, ipaddress, macaddress, disto, packages } = req.body;
  const query = 'UPDATE info SET hostname = $1, ipaddress = $2, macaddress = $3, disto = $4, packages = $5 WHERE id = $6 RETURNING *';

  try {
    const { rows } = await pool.query(query, [hhostname, ipaddress, macaddress, disto, packages, id]);
    res.json(rows[0]);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Delete an item
app.delete('/info/:id', async (req, res) => {
  const { id } = req.params;
  const query = 'DELETE FROM info WHERE id = $1';

  try {
    await pool.query(query, [id]);
    res.sendStatus(204);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
});


// Create a new item
app.post('/packages', async (req, res) => {
  const { hostname, ipaddress, macaddress, disto, packages  } = req.body; // Updated variable names

  // Check if 'hostname' is provided in the request body
  if (!hostname) {
    return res.status(400).json({ error: 'Missing hostname in request body' });
  }

  const query = 'INSERT INTO packages (hostname, git, wget, sudo, python, python3, nettools, postgresql, libpython, dockercecli, dockercomposeplugin, curl, containerd) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12) RETURNING *';

  try {
    const { rows } = await pool.query(query, [hostname, git, wget, sudo, python, python3, nettools, postgresql, libpython, dockercecli, dockercomposeplugin, curl, containerd]);
    res.status(201).json(rows[0]);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Retrieve all items
app.get('/packages', async (req, res) => {
  try {
    const { rows } = await pool.query('SELECT * FROM packages');
    res.json(rows);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Update an item
app.put('/packages/:id', async (req, res) => {
  const { id } = req.params;
  const { hostname, git, wget, sudo, python, python3, nettools, postgresql, libpython, dockercecli, dockercomposeplugin, curl, containerd } = req.body;
  const query = 'UPDATE packages SET hostname = $1, git = $2, wget = $3, sudo = $4, python = $5, python3 = $6, nettools = $7, postgresql = $8, libpython = $9, dockercecli = $10, dockercomposeplugin = $11, curl = $11, containerd = $12 WHERE id = $13 RETURNING *';

  try {
    const { rows } = await pool.query(query, [hostname, git, wget, sudo, python, python3, nettools, postgresql, libpython, dockercecli, dockercomposeplugin, curl, containerd]);
    res.json(rows[0]);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Delete an item
app.delete('/packages/:id', async (req, res) => {
  const { id } = req.params;
  const query = 'DELETE FROM packages WHERE id = $1';

  try {
    await pool.query(query, [id]);
    res.sendStatus(204);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
});


app.listen(port, () => {
  console.log(`Node.js API is running on port ${port}`);
});