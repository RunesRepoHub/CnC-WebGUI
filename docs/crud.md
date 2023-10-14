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