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
  const { table } = req.params;
  const data = req.body;
  const columns = Object.keys(data);
  const placeholders = columns.map((_, index) => `$${index + 1}`);
  const query = `INSERT INTO ${table} (${columns.join(', ')}) VALUES (${placeholders.join(', ')}) RETURNING *`;
  const values = Object.values(data);

  if (columns.length === 0) {
    return res.status(400).json({ error: 'No data provided' });
  }

  handleDatabaseOperation(query, values, res);
});

app.post('/create/cronjobs', async (req, res) => {
  const data = req.body;

  const query = `INSERT INTO cronjobs (hostname, cronjobsscripts) VALUES ($1, $2) RETURNING *`;
  const values = [data.hostname, data.cronjobsscripts];

  handleDatabaseOperation(query, values, res);
});



app.get('/read/:table/:hostname', (req, res) => {
  const { table, hostname } = req.params;
  const query = `SELECT * FROM ${table} WHERE hostname = $1`;

  handleDatabaseOperation(query, [hostname], res);
});

// Update an item (Generic function for different tables)
app.put('/update/packages/:hostname', (req, res) => {
  const { hostname } = req.params;
  const data = req.body;
  const columns = Object.keys(data);
  const query = `UPDATE packages SET ${columns.map((col, index) => `${col} = $${index + 1}`).join(', ')} WHERE hostname = $${columns.length + 1} RETURNING *`;
  const values = [...Object.values(data), hostname];

  handleDatabaseOperation(query, values, res);
});

// Update an item for "info" table
app.put('/update/info/:hostname', (req, res) => {
  const { hostname } = req.params;
  const data = req.body;
  const columns = Object.keys(data);
  const query = `UPDATE info SET ${columns.map((col, index) => `${col} = $${index + 1}`).join(', ')} WHERE hostname = $${columns.length + 1} RETURNING *`;
  const values = [...Object.values(data), hostname];

  handleDatabaseOperation(query, values, res);
});

// Update an item for "cronjobs" table
app.put('/update/cronjobs/:hostname', (req, res) => {
  const { hostname } = req.params;
  const data = req.body;
  const columns = Object.keys(data);
  const query = `UPDATE cronjobs SET ${columns.map((col, index) => `${col} = $${index + 1}`).join(', ')} WHERE hostname = $${columns.length + 1} RETURNING *`;
  const values = [...Object.values(data), hostname];

  handleDatabaseOperation(query, values, res);
});

// Delete an item (Generic function for different tables)
app.delete('/delete/:table/:id', (req, res) => {
  const { table, id } = req.params;
  const query = `DELETE FROM ${table} WHERE id = $1`;

  handleDatabaseOperation(query, [id], res);
});

app.listen(port, () => {
  console.log(`Node.js API is running on port ${port}`);
});
