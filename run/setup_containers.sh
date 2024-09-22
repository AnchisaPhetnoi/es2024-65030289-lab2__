#!/bin/bash

# Create Nginx container
echo "Creating Nginx container..."
docker run -d --name nginx-container -p 80:80 nginx

# Create web page on Nginx container
echo "Creating web page on Nginx container..."
docker exec -it nginx-container sh -c 'echo "<h1>Hello from Nginx</h1>" > /usr/share/nginx/html/index.html'

# Create Express container
echo "Creating Express container..."
docker run -d --name express-container -p 3000:3000 node

# Connect web page from Nginx container to Express container
echo "Connecting web page from Nginx to Express..."
# Add any necessary configuration here

# Create MongoDB container
echo "Creating MongoDB container..."
docker run -d --name mongodb-container -p 27017:27017 mongo

# Insert dummy data to MongoDB container
echo "Inserting dummy data into MongoDB..."
# Add your MongoDB commands here

# Connect Express container to MongoDB container
echo "Connecting Express container to MongoDB..."
# Add your connection logic here

# Create CRUD API on Express container
echo "Creating CRUD API on Express container..."
# Add your API code here

# Create web page on Nginx container to test Express CRUD API
echo "Creating test web page for CRUD API..."
# Add your test web page code here
