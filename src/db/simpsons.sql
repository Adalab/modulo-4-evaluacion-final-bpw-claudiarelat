CREATE DATABASE IF NOT EXISTS simpsons; 
USE simpsons; 

CREATE TABLE IF NOT EXISTS personajes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100),
    ocupacion VARCHAR(255),
    descripcion TEXT
);


CREATE TABLE IF NOT EXISTS capitulos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    numero_episodio INT,
    temporada INT,
    fecha_emision DATE,
    sinopsis TEXT
);


CREATE TABLE IF NOT EXISTS frases (
    id INT AUTO_INCREMENT PRIMARY KEY,
    texto TEXT NOT NULL,
    marca_tiempo VARCHAR(10),  -- formato tipo '12:34'
    descripcion TEXT,
    personaje_id INT,
    FOREIGN KEY (personaje_id) REFERENCES personajes(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- Crear tabla intermedia para relación N:M entre personajes y capítulos
CREATE TABLE IF NOT EXISTS personajes_capitulos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    personaje_id INT,
    capitulo_id INT,
    FOREIGN KEY (personaje_id) REFERENCES personajes(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (capitulo_id) REFERENCES capitulos(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    UNIQUE (personaje_id, capitulo_id)  -- Evita duplicados
);

INSERT INTO personajes (nombre, apellido, ocupacion, descripcion) VALUES
('Homer', 'Simpson', 'Inspector de seguridad nuclear', 'Le encanta la cerveza Duff y los donuts'),
('Marge', 'Simpson', 'Ama de casa', 'Tiene un gran peinado azul'),
('Lisa', 'Simpson', 'Estudiante', 'Inteligente, toca el saxofón'),
('Bart', 'Simpson', 'Estudiante', 'Travieso y rebelde'),
('Charles',  'Montgomery Burns', 'Propietario de la Planta Nuclear de Springfield', 'Codicioso, amargado y excéntrico'),
('Abraham', 'Simpson', 'Jubilado', 'Abuelo paterno de la familia protagonista'),
('Ned', 'Flanders', 'Propietario de Leftorium, tienda especializada en productos para personas zurdas', 'Bondadoso, amigable y cristiano devoto'),
('Hans', 'Topo', 'Empleos esporádicos', 'Solitario y con poca vista, tiene un problema con el alchohol y por eso aparenta 80 años'),
('Moe', 'Szyslak', 'Propietario y único camarero de la Taberna de Moe', 'Feo y suicida'),
('Apu', 'Nahasapeemapetilon', 'Dueño y dependiente del badulaque', 'Es tenaz y tiene un exagerado acento indio'),
('Ralph', 'Wiggum', 'Estudiante', 'Errático, infantil y estúpido'),
('Nelson', 'Muntz', 'Estudiante', 'Es fuerte, abusón, le encanta golpear y fastidiar a los demás');


INSERT INTO frases (texto, marca_tiempo, descripcion, personaje_id) VALUES
('¡Estúpido Flanders y su erotismo!', NULL, NULL, 1),
('¡Oh, mírame, Marge! Estoy haciendo feliz a mucha gente, soy el hombre mágico del pais feliz de la casa de la gominola en la calle de la piruleta', NULL, NULL, 1),
('¡Por favor, no me comáis! Tengo mujer e hijos ¡Comeros a ellos!', NULL, NULL, 1),
('¡Qué suerte Marge!, Nuestros hijos son cada vez más inteligentes, si tenemos otro podría construir una máquina del tiempo para viajar al pasado y no tener hijos', NULL, NULL, 1),
('¿Me podría decir dónde está el lavabo? Me gustaría fingir que me lavo las manos', NULL, NULL, 1),
('¿Y si nos equivocamos de religión? Dios estaría más furioso cada semana', NULL, NULL, 1),
('Cuando miro las caras sonrientes de los niños, sólo sé que están planeando golpearme con algo', NULL, NULL, 1),
('Hay dos tipos de estudiantes: los fuertes y los gilis. ¡Como atleta es mi deber hacerle la vida imposible a los gilis!', NULL, NULL, 1),
('Librarte de formar parte de un jurado popular es fácil. Solo tienes que decir que tienes prejuicios contra todas las razas.', NULL, NULL, 1),
('Lisa, los vampiros son seres inventados, como los duendes, los gremlins y los esquimales', NULL, NULL, 1),
('Mar, retrete del mundo. Los griegos te llamaban Poseidón, los romanos, eeeeh Aquaman', NULL, NULL, 1),
('Sabes que no soy aficionado a rezar, pero si estás ahí arriba, ¡sálvame Superman!', NULL, NULL, 1),
('Puede tener todo el dinero del mundo, pero hay algo que nunca podrá comprar… Un dinosaurio', NULL, NULL, 1),
('Sabéis hijos, un reactor nuclear es como una mujer. Solo tienes que leer el manual y apretar los botones adecuados', NULL, NULL, 1),
('Sí, Marge, en teoría estoy contigo, pero en teoría funciona hasta el comunismo', NULL, NULL, 1),
('¡Milhouse, ¿Cómo alguien con unas gafas tan grandes puede ser tan tonto?!', NULL, NULL, 4),
('Judías, judías legumbre musical. Cuántas más comas, más música habrá', NULL, NULL, 4),
('Multiplícate por cero', NULL, NULL, 4),
('¡Soy un unicornio retrasado!', NULL, NULL, 11),
('El aliento de mi gato huele a comida de gato', NULL, NULL, 11),
('Trabajo mucho y quiero a mis hijos, ¿por qué voy a pasar la mitad del domingo oyendo que me voy a ir al infierno?', NULL, NULL, 1),
('¿Cuánto cobran los extras de cine? Porque dicen que me parezco a Macaulay Culkin', NULL, NULL, 9),
('¡Bart, no molestes a Satanás!', NULL, NULL, 2),
('Lo siento, papá. Prometo que nunca más comeré carne', NULL, NULL, 3),
('¡Excelente!', NULL, NULL, 5),
('¡Smithers, libere a los perros!', NULL, NULL, 5),
('Quiero ese sol tapado... ¡para siempre!', NULL, NULL, 5),
('¡Esos mocosos llevan pantalones por debajo de la cintura! ¡Degeneración absoluta!', NULL, NULL, 5),
('¡Quiero morir tranquilo en mi sillón, como mi abuelo! ¡No gritando de terror, como sus pasajeros!', NULL, NULL, 6),
('¡Joven, devuélvame mi dentadura o le denunciaré al barbero!', NULL, NULL, 6),
('¡Los jóvenes de hoy no saben respetar! ¡Tienen videojuegos, pantalones con cremallera y emociones!', NULL, NULL, 6),
('¡Hola, holita, vecinito!', NULL, NULL, 7),
('¡Oh cielos! ¡Una palabrota! ¡Voy a lavarme los oídos con jabón bendito!', NULL, NULL, 7),
('Oh, Todd, Rod, cubríos los ojos. ¡Ese señor lleva pantalones cortos!', NULL, NULL, 7),
('¡Dios no cierra una puerta sin abrir una ventanita!', NULL, NULL, 7),
('El dentista dice que tengo dientes de madera.', NULL, NULL, 8),
('Pensaba que esto era un urinario', NULL, NULL, 8),
('¡Ya está bien, Homer, fuera de mi bar!', NULL, NULL, 9),
('¡Escuchad todos! Si alguien pregunta, no servimos alcohol a menores... ni a humanos.', NULL, NULL, 9),
('Tengo cámaras por todo el bar... por seguridad, claro. Y porque me siento solo.', NULL, NULL, 9),
('A veces me gustaría dormir para siempre... pero luego recuerdo que tengo que abrir el bar.', NULL, NULL, 9),
('No necesito dormir, tengo el poder del amor… y unas cuantas anfetaminas.', NULL, NULL, 10),
('Todo lo que tengo lo he conseguido con trabajo duro, esfuerzo… y algunos papeles poco fiables', NULL, NULL, 10),
('Por favor, no me denuncie. Ya tengo cuatro juicios pendientes esta semana', NULL, NULL, 10),
('Esto no es un arma… es un dispositivo disuasorio de clientes conflictivos', NULL, NULL, 10),
('Eh, no tengo padre… o bueno, se fue a por tabaco y se perdió en el Triángulo de las Bermudas', NULL, NULL, 12),
('¿Sabías que si golpeas a alguien en el estómago después de comer… sale como un géiser?', NULL, NULL, 12),
('¡Ese bocata tenía mayonesa! ¡Y ya sabes lo que pasa cuando como mayonesa!', NULL, NULL, 12);


INSERT INTO capitulos (titulo, numero_episodio, temporada, fecha_emision, sinopsis) VALUES
('Simpsons Roasting on an Open Fire', 1, 1, '1989-12-17', 'Homer se convierte en Santa Claus para ganar dinero extra y salva la Navidad.'),
('Bart el Genio', 2, 1, '1990-01-14', 'Bart hace trampa en un test de inteligencia y es enviado a una escuela para superdotados.'),
('Homer vs. Lisa and the 8th Commandment', 13, 2, '1991-02-07', 'Lisa se enfrenta a su padre por robar cable, cuestionando su moralidad.'),
('Lisa la Vegetariana', 5, 7, '1995-10-15', 'Lisa decide dejar de comer carne tras visitar un parque temático con animales.'),
('El enemigo de Homero', 23, 8, '1997-05-04', 'Homer se enfrenta a un nuevo compañero de trabajo, Frank Grimes.'),
('Solo se muda dos veces', 2, 8, '1996-11-03', 'La familia se muda y Homer trabaja para Hank Scorpio en una empresa tecnológica.'),
('La ciudad de Nueva York contra Homero', 1, 9, '1997-09-21', 'La familia viaja a Nueva York para recuperar el coche de Homer.'),
('El niño que sabía demasiado', 20, 5, '1994-05-05', 'Bart testifica en un juicio que podría perjudicar a su enemigo, Skinner.');


INSERT INTO personajes_capitulos (personaje_id, capitulo_id) VALUES
(1, 1), -- Homer en el episodio 1
(2, 1), -- Marge en el episodio 1
(3, 1), -- Lisa en el episodio 1
(4, 1), -- Bart en el episodio 1

(1, 2),
(4, 2),

(1, 3),
(3, 3),

(3, 4), -- Lisa protagonista
(2, 4), -- Marge apoya
(1, 4), -- Homer reacciona

(1, 5), -- Homer vs Grimes
(5, 5), -- Burns y su planta

(1, 6),
(2, 6),
(3, 6),
(4, 6),

(1, 7),
(4, 7),
(9, 7), -- Moe en NY

(4, 8),
(12, 8); -- Nelson involucrado