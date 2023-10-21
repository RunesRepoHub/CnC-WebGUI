# CRUD Source Code
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


## CnC API

### Creating a Server:
```
curl -X POST -H "Content-Type: application/json" -d '{
  "name": "My Server",
  "ip_address": "your_server_ip",
  "ssh_username": "your_ssh_username",
  "ssh_password": "your_ssh_password"
}' http://localhost:3000/servers
```

### Retrieving Servers:
```
curl http://localhost:3000/servers
```

#### Updating a Server:
```
curl -X PUT -H "Content-Type: application/json" -d '{
  "name": "Updated Server Name",
  "ip_address": "updated_server_ip",
  "ssh_username": "updated_ssh_username",
  "ssh_password": "updated_ssh_password"
}' http://localhost:3000/servers/1  # Replace 1 with the server's ID
```

### Deleting a Server:
```
curl -X DELETE http://localhost:3000/servers/1  # Replace 1 with the server's ID
```

### SSH into a Server:
```
curl -X POST http://localhost:3000/servers/ssh/1  # Replace 1 with the server's ID
```

### SSH Commands
```
curl -X POST -H "Content-Type: application/json" -d '{"command": "reboot"}' http://192.168.1.203:3001/servers/ssh/1

```