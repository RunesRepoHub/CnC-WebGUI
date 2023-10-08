const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

// MySQL Connection
const db = mysql.createConnection({
  host: '192.168.1.45',
  user: 'root',
  password: 'RuneProduction',
  database: 'CnC-WebGUI-test',
});

db.connect((err) => {
  if (err) {
    console.error('Error connecting to MySQL:', err);
    return;
  }
  console.log('Connected to MySQL database');
});

// Middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// Routes
app.get('/items', (req, res) => {
  db.query('SELECT * FROM cronjobs', (err, results) => {
    if (err) {
      console.error('Error fetching data:', err);
      res.status(500).json({ error: 'Internal Server Error' });
      return;
    }
    res.json(results);
  });
});

app.post('/items', (req, res) => {
  const { name, description } = req.body;
  db.query('INSERT INTO cronjobs (hostname, cron_jobs_scripts) VALUES (?, ?)', [name, description], (err, results) => {
    if (err) {
      console.error('Error inserting data:', err);
      res.status(500).json({ error: 'Internal Server Error' });
      return;
    }
    res.json({ message: 'Item added successfully', id: results.insertId });
  });
});

app.put('/items/:id', (req, res) => {
  const { id } = req.params;
  const { name, description } = req.body;
  db.query('UPDATE cronjobs SET name=?, description=? WHERE id=?', [name, description, id], (err, results) => {
    if (err) {
      console.error('Error updating data:', err);
      res.status(500).json({ error: 'Internal Server Error' });
      return;
    }
    res.json({ message: 'Item updated successfully', id });
  });
});

app.delete('/items/:id', (req, res) => {
  const { id } = req.params;
  db.query('DELETE FROM cronjobs WHERE id=?', [id], (err, results) => {
    if (err) {
      console.error('Error deleting data:', err);
      res.status(500).json({ error: 'Internal Server Error' });
      return;
    }
    res.json({ message: 'Item deleted successfully', id });
  });
});

// Start the server
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});