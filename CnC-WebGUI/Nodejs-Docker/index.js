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

// Update data based on hostname (for packages table)
app.put('/update/packages/:hostname', (req, res) => {
  const { hostname } = req.params;
  const data = req.body;
  const columns = Object.keys(data);
  const query = `UPDATE packages SET ${columns.map((col, index) => `${col} = $${index + 1}`).join(', ')} WHERE hostname = $${columns.length + 1} RETURNING *`;
  const values = [...Object.values(data), hostname];

  handleDatabaseOperation(query, values, res);
});

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
