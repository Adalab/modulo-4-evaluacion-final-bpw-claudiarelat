//importaciones
const express = require('express'); 
const cors = require('cors');
const mysql = require('mysql2');
require('dotenv').config();

//creación del servidor 
const PORT = process.env.PORT || 4000;
const server = express();
server.use(cors());
server.use(express.json());

server.listen(PORT, () => {
    console.log(`Servidor iniciado en el puerto ${PORT}`);
})

//conexión a la base de datos
const getConnection = async () => {
    return await mysql.createConnection({
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_NAME,
        port: process.env.DB_PORT
    });
}

//endpoint para obtener todos los personajes
server.get('/personajes', async (req, res) => {
    try {
        const conn = await getConnection();
        const [rows] = await conn.execute('SELECT * FROM personajes');
        res.json(rows);
        await conn.end();
    } catch (error) {
        console.error('Error al obtener personajes:', error);
        res.status(500).json({ error: 'Error al obtener personajes' });
    }
})

//escuchan el servidor 

