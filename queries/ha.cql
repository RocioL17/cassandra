-- Demo de Alta Disponibilidad (HA): trade-off entre consistencia y disponibilidad.

-- Paso previo (en la terminal, no en cqlsh): tirar un nodo del cluster
--   docker stop cassandra-3

-- 1) Con consistencia baja, el cluster sigue respondiendo aunque falte un nodo (RF=3, 1 caído)
CONSISTENCY LOCAL_ONE;
INSERT INTO plataforma_streaming.historial_reproduccion
    (user_id, video_id, titulo_contenido, tipo_contenido, segundo_pausado, completado, ultima_reproduccion)
VALUES
    ('user_25', 'vid_005', 'Stranger Things', 'serie', 1800, false, toTimestamp(now()));

SELECT * FROM plataforma_streaming.historial_reproduccion
WHERE user_id = 'user_25' AND video_id = 'vid_005';

-- 2) Con consistencia ALL, la misma operación falla porque no responden todos los nodos
CONSISTENCY ALL;
INSERT INTO plataforma_streaming.historial_reproduccion
    (user_id, video_id, titulo_contenido, tipo_contenido, segundo_pausado, completado, ultima_reproduccion)
VALUES
    ('user_25', 'vid_006', 'The Crown', 'serie', 300, false, toTimestamp(now()));
-- Resultado esperado: Cassandra timeout/unavailable exception

-- Paso final (en la terminal): levantar el nodo de nuevo
--   docker start cassandra-3
