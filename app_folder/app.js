const express = require('express');
const { MongoClient, ObjectId } = require('mongodb');

const app = express();
const PORT = 3000;

const uri = 'mongodb://my-mongo:27017'; // ชื่อคอนเทนเนอร์ MongoDB
const client = new MongoClient(uri);

app.use(express.json()); // เพื่อให้สามารถรับ JSON ได้

async function run() {
    try {
        await client.connect();
        console.log('Connected to MongoDB');

        const database = client.db('your_database_name'); // เปลี่ยนเป็นชื่อฐานข้อมูลของคุณ
        const collection = database.collection('your_collection_name'); // เปลี่ยนเป็นชื่อคอลเลกชันของคุณ

        app.get('/', (req, res) => {
            res.send('<h1>Hello, Express from Docker!</h1>');
        });

        // สร้างข้อมูลใหม่
        app.post('/items', async (req, res) => {
            const newItem = req.body;
            const result = await collection.insertOne(newItem);
            res.status(201).json(result);
        });

        // อ่านข้อมูลทั้งหมด
        app.get('/items', async (req, res) => {
            const results = await collection.find({}).toArray();
            res.json(results);
        });

        // อัปเดตข้อมูล
        app.put('/items/:id', async (req, res) => {
            const id = req.params.id;
            const updatedItem = req.body;
            const result = await collection.updateOne({ _id: new ObjectId(id) }, { $set: updatedItem });
            res.json(result);
        });

        // ลบข้อมูล
        app.delete('/items/:id', async (req, res) => {
            const id = req.params.id;
            const result = await collection.deleteOne({ _id: new ObjectId(id) });
            res.json(result);
        });

        app.listen(PORT, () => {
            console.log(`Server is running on http://localhost:${PORT}`);
        });
    } catch (error) {
        console.error(error);
    }
}

run().catch(console.dir);

