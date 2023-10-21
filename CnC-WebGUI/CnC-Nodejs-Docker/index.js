const express = require('express');
const bodyParser = require('body-parser');
const { Client } = require('ssh2');
const pgp = require('pg-promise')();
const db = pgp('postgresql://root:12Marvel@cnc-db:5432/machines');

const app = express();
app.use(bodyParser.json());

// Create a new server record
app.post('/servers', async (req, res) => {
  const { name, ip_address, ssh_username, ssh_password } = req.body;

  const newServer = await db.one(
    'INSERT INTO servers(name, ip_address, ssh_username, ssh_password) VALUES($1, $2, $3, $4) RETURNING *',
    [name, ip_address, ssh_username, ssh_password]
  );

  res.json(newServer);
});

// Read server information
app.get('/servers', async (req, res) => {
  const servers = await db.any('SELECT * FROM servers');
  res.json(servers);
});

// Update server information
app.put('/servers/:id', async (req, res) => {
  const { id } = req.params;
  const { name, ip_address, ssh_username, ssh_password } = req.body;

  const updatedServer = await db.oneOrNone(
    'UPDATE servers SET name=$1, ip_address=$2, ssh_username=$3, ssh_password=$4 WHERE id=$5 RETURNING *',
    [name, ip_address, ssh_username, ssh_password, id]
  );

  if (updatedServer) {
    res.json(updatedServer);
  } else {
    res.status(404).send('Server not found');
  }
});

// Delete a server record
app.delete('/servers/:id', async (req, res) => {
  const { id } = req.params;

  const deletedServer = await db.oneOrNone('DELETE FROM servers WHERE id=$1 RETURNING *', id);

  if (deletedServer) {
    res.json(deletedServer);
  } else {
    res.status(404).send('Server not found');
  }
});

// SSH into a server
app.post('/servers/ssh/:id', async (req, res) => {
  const { id } = req.params;

  const server = await db.oneOrNone('SELECT * FROM servers WHERE id = $1', id);

  if (!server) {
    res.status(404).send('Server not found');
    return;
  }

  const conn = new Client();

  conn.on('ready', () => {
    conn.shell((err, stream) => {
      if (err) throw err;

      // You can interact with the SSH shell here
      stream.on('data', (data) => {
        res.write(data);
      });

      stream.on('close', () => {
        conn.end();
        res.end();
      });

      stream.end('ls -la\n');
    });
  });

  conn.on('error', (err) => {
    res.status(500).send('SSH Error: ' + err.message);
  });

  conn.connect({
    host: server.ip_address,
    port: 22,
    username: server.ssh_username,
    password: server.ssh_password,
  });
});

const PORT = process.env.PORT || 3001;

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
