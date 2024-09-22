#!/bin/bash

# Create Nginx container
echo "Creating Nginx container..."
docker run -d --name nginx-container -p 80:80 nginx

# Create web page on Nginx container
echo "Creating web page on Nginx container..."
echo "<h1>Hello from Nginx!</h1>" > index.html
docker cp index.html nginx-container:/usr/share/nginx/html/index.html

# Create Express container
echo "Creating Express container..."
docker run -d --name express-container -p 3000:3000 your-express-image

# Connect webpage from Nginx container to Express container
echo "Connecting web page from Nginx container to Express container..."
docker exec -it nginx-container bash -c 'echo "server { listen 80; location / { proxy_pass http://express-container:3000; }}" > /etc/nginx/conf.d/default.conf'
docker restart nginx-container

# Create MongoDB container
echo "Creating MongoDB container..."
docker run -d --name mongodb-container -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=password mongo

# Insert dummy data into MongoDB container
echo "Inserting dummy data into MongoDB container..."
docker exec -it mongodb-container mongo --username root --password password --eval 'db.test.insertMany([{name: "Item 1"}, {name: "Item 2"}])'

# Connect Express container to MongoDB container
echo "Connecting Express container to MongoDB..."
docker exec -it express-container bash -c 'export MONGODB_URI="mongodb://root:password@mongodb-container:27017/test"; node your-express-app.js'

# Create CRUD API on Express container
echo "Creating CRUD API on Express container..."
# Add your CRUD API implementation here

# Create web page on Nginx container to test Express CRUD API
echo "Creating test web page for CRUD API..."
echo "<h1>Test Express CRUD API</h1>" > api_test.html
docker cp api_test.html nginx-container:/usr/share/nginx/html/api_test.html

echo "Setup complete!"