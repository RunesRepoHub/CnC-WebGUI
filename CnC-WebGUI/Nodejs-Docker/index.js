const express = require('express');
const { Pool } = require('pg');
const SSH2Client = require('ssh2').Client;

const app = express();
const port = 3000;

const pool = new Pool({
  user: 'root',
  host: 'cnc-db',
  database: 'machines',
  password: '12Marvel',
  port: 5432,
});

const pool = new Client(dbConfig);
const sshClient = new SSH2Client();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Reusable function to handle database operations
async function handleDatabaseOperationAll(query, values, res, tableName) {
  try {
    const { rows } = await pool.query(query, values);
    res.status(200).json(rows); // Return all rows
  } catch (error) {
    logError(error); // Log the error for debugging
    res.status(500).json({ error: `Internal Server Error: Failed to retrieve data from ${tableName} table` });
  }
}

async function handleDatabaseOperationSingle(query, values, res) {
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

  handleDatabaseOperationSingle(query, values, res);
});

app.post('/create/cronjobs', async (req, res) => {
  const data = req.body;

  const query = `INSERT INTO cronjobs (hostname, cronjobsscripts) VALUES ($1, $2) RETURNING *`;
  const values = [data.hostname, data.cronjobsscripts];

  handleDatabaseOperationSingle(query, values, res);
});


app.get('/read/:table/:hostname', (req, res) => {
  const { table, hostname } = req.params;
  const query = `SELECT * FROM ${table} WHERE hostname = $1`;

  handleDatabaseOperationSingle(query, [hostname], res);
});

app.get('/read/:table/:hostname/:package', (req, res) => {
  const { table, hostname, package } = req.params;
  const query = `SELECT * FROM ${table} WHERE hostname = $1 AND packagename = $2`;

  handleDatabaseOperationSingle(query, [hostname, package], res);
});

// Update an item (Generic function for different tables)
app.put('/update/packages/:hostname', (req, res) => {
  const { hostname } = req.params;
  const data = req.body;
  const columns = Object.keys(data);
  const query = `UPDATE packages SET ${columns.map((col, index) => `${col} = $${index + 1}`).join(', ')} WHERE hostname = $${columns.length + 1} RETURNING *`;
  const values = [...Object.values(data), hostname];

  handleDatabaseOperationSingle(query, values, res);
});

// Update an item (Generic function for different tables)
app.put('/update/packages/:hostname/:package', (req, res) => {
  const { hostname, package } = req.params;
  const data = req.body;
  const columns = Object.keys(data);

  // Check if the 'package' parameter matches any column name
  if (columns.includes(package)) {
    const query = `UPDATE packages SET ${columns.map((col, index) => `${col} = $${index + 1}`).join(', ')} WHERE hostname = $${columns.length + 1} RETURNING *`;
    const values = [...Object.values(data), hostname];

    handleDatabaseOperationSingle(query, values, res);
  } else {
    res.status(400).json({ error: 'The specified package is not in the columns.' });
  }
});

// Update an item for "info" table
app.put('/update/info/:hostname', (req, res) => {
  const { hostname } = req.params;
  const data = req.body;
  const columns = Object.keys(data);
  const query = `UPDATE info SET ${columns.map((col, index) => `${col} = $${index + 1}`).join(', ')} WHERE hostname = $${columns.length + 1} RETURNING *`;
  const values = [...Object.values(data), hostname];

  handleDatabaseOperationSingle(query, values, res);
});

// Update an item for "cronjobs" table
app.put('/update/cronjobs/:hostname', (req, res) => {
  const { hostname } = req.params;
  const data = req.body;
  const columns = Object.keys(data);
  const query = `UPDATE cronjobs SET ${columns.map((col, index) => `${col} = $${index + 1}`).join(', ')} WHERE hostname = $${columns.length + 1} RETURNING *`;
  const values = [...Object.values(data), hostname];

  handleDatabaseOperationSingle(query, values, res);
});

// Delete an item (Generic function for different tables)
app.delete('/delete/:table/:id', (req, res) => {
  const { table, id } = req.params;
  const query = `DELETE FROM ${table} WHERE id = $1`;

  handleDatabaseOperationSingle(query, [id], res);
});

// Add a function to log errors
function logError(error) {
  console.error('Error:', error);
}

// Read all data for the table
app.get('/read/:table', (req, res) => {
  const { table } = req.params;
  const query = `SELECT * FROM ${table}`; // Use backticks for template literals
  handleDatabaseOperationAll(query, [], res, 'cronjobs'); // Pass the table name for better error messages
});

app.post('/send-command', (req, res) => {
  // Collect user input for SSH username and password
  const { hostname, command, sshUsername, sshPassword } = req.body;

  pool.connect()
    .then(() => {
      return pool.query('SELECT ip_address FROM hostnames WHERE hostname = $1', [hostname]);
    })
    .then((result) => {
      const ip = result.rows[0].ip_address;

      const sshConfig = {
        port: 22, // Default SSH port
        username: sshUsername,
        password: sshPassword,
        host: ip,
      };

      sshClient.on('ready', () => {
        sshClient.shell((err, stream) => {
          if (err) {
            res.status(500).json({ error: 'SSH connection failed' });
            return;
          }

          stream.write(`${command}\n`);
          stream.end();

          let output = '';

          stream.on('data', (data) => {
            output += data;
          });

          stream.on('close', () => {
            sshClient.end();
            pool.end();
            res.json({ output });
          });
        });
      });

      sshClient.connect(sshConfig);
    })
    .catch((err) => {
      res.status(500).json({ error: 'Database connection failed' });
    });
});

// Add a function to log errors
function logError(error) {
  console.error('Error:', error);
}



app.listen(port, () => {
  console.log(`Node.js API is running on port ${port}`);
});
