//importaciones
const express = require('express'); 
const cors = require('cors');
const mysql = require('mysql2/promise');
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

//escuchar el servidor 
//endpoint para obtener todas los frases con sus personajes
server.get('/frases', async (req, res) => {
    try {
        const conn = await getConnection();
        const [rows] = await conn.query('select frases.id, nombre, apellido, texto from frases left join personajes on frases.personaje_id = personajes.id order by frases.id');
        
        res.json({
            info: {"count": rows.length},
            result: rows  
        });
        
        await conn.end();
        
    } catch (error) {
        console.error('Error al obtener las frases:', error);
        res.status(500).json({ error: 'Error al obtener las frases' });
    }
})


// Obtener una frase por su ID
server.get('/frases/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const connection = await getConnection();
    const [rows] = await connection.query('select nombre, apellido, texto from frases left join personajes on frases.personaje_id = personajes.id WHERE frases.id = ?', [id]);
    await connection.end();

    if (rows.length === 0) {
      return res.status(404).json({ error: 'Frase no encontrada' });
    }

    res.json(rows[0]);

  } catch (error) {
    res.status(500).json({ error: 'Error al obtener la frase' });
  }
});

// Crear una nueva frase
server.post('/frases', async (req, res) => {
  const { texto, personaje_id } = req.body;

  if (!texto || !personaje_id) {
    return res.status(400).json({
      success: false,
      message: 'Faltan campos obligatorios: texto o personaje_id'
    });
  }

  try {
    const connection = await getConnection();
    const [result] = await connection.query(
      'INSERT INTO frases (texto, personaje_id) VALUES (?, ?)',
      [texto, personaje_id]
    );
    await connection.end();

    res.status(201).json({
      success: true,
      id: result.insertId
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error al crear la frase'
    });
  }
});

// Actualizar una frase existente
server.put('/frases/:id', async (req, res) => {
  const { id } = req.params;
  const { texto, personaje_id } = req.body;

  if (!texto || !personaje_id) {
    return res.status(400).json({
      success: false,
      message: 'Faltan campos obligatorios: texto o personaje_id'
    });
  }

  try {
    const connection = await getConnection();
    const [result] = await connection.execute(
      'UPDATE frases SET texto = ?, personaje_id = ? WHERE id = ?',
      [texto, personaje_id, id]
    );
    await connection.end();

    if (result.affectedRows === 0) {
      return res.status(404).json({
        success: false,
        message: 'Frase no encontrada'
      });
    }

    res.json({ success: true });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error al actualizar la frase'
    });
  }
});


// Eliminar una frase
server.delete('/frases/:id', async (req, res) => {
  const { id } = req.params;

  try {
    const connection = await getConnection();
    const [result] = await connection.query(
      'DELETE FROM frases WHERE id = ?',
      [id]
    );
    await connection.end();

    if (result.affectedRows === 0) {
      return res.status(404).json({
        success: false,
        message: 'Frase no encontrada'
      });
    }

    res.json({ success: true });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error al eliminar la frase'
    });
  }
});
