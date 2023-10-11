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
  const { name, description } = req.body;
  const query = 'UPDATE cronjob SET name = $1, description = $2 WHERE id = $3 RETURNING *';

  try {
    const { rows } = await pool.query(query, [name, description, id]);
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

app.listen(port, () => {
  console.log(`Node.js API is running on port ${port}`);
});