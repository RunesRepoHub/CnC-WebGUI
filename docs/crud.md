# CRUD Source Code

Creating a Node.js REST API that interacts with a MySQL database and handles CRUD operations using curl involves several steps. Here's a basic example to get you started. Make sure you have Node.js and MySQL installed on your system before proceeding.

1. Set up your MySQL database:
Create a MySQL database and table. You can use a tool like phpMyAdmin or the MySQL command line to do this. Here's a simple example:

```
CREATE DATABASE mydb;
USE mydb;

CREATE TABLE items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT
);
```

2. Install necessary Node.js packages:
In your project directory, run the following command to install the required Node.js packages:

```
npm install express mysql body-parser
```

3. Create the index.js file for your Node.js API:

```
const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

// MySQL Connection
const db = mysql.createConnection({
  host: 'localhost',
  user: 'your_username',
  password: 'your_password',
  database: 'mydb',
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
  db.query('SELECT * FROM items', (err, results) => {
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
  db.query('INSERT INTO items (name, description) VALUES (?, ?)', [name, description], (err, results) => {
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
  db.query('UPDATE items SET name=?, description=? WHERE id=?', [name, description, id], (err, results) => {
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
  db.query('DELETE FROM items WHERE id=?', [id], (err, results) => {
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
```

4. Run your Node.js server:

```
node index.js
```

Your REST API is now running on http://localhost:3000. You can use curl to access, update, upload, and delete data from the MySQL database:

To GET all items:
```
curl http://localhost:3000/items
```

To POST (create) a new item:

```
curl -X POST -H "Content-Type: application/json" -d '{"name": "New Item", "description": "Description of the new item"}' http://localhost:3000/items
```

To PUT (update) an item with a specific ID (replace :id with the actual ID):
```
curl -X PUT -H "Content-Type: application/json" -d '{"name": "Updated Item", "description": "Updated description"}' http://localhost:3000/items/:id
```


To DELETE an item with a specific ID (replace :id with the actual ID):

```
curl -X DELETE http://localhost:3000/items/:id
```

Make sure to replace 'your_username' and 'your_password' with your MySQL credentials in the database connection configuration.