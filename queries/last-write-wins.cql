-- Demo de Last Write Wins (LWW): Cassandra resuelve conflictos por TIMESTAMP, no por orden de llegada.

-- 1) Escritura "nueva" (timestamp 2000) llega primero
INSERT INTO plataforma_streaming.historial_reproduccion
    (user_id, video_id, titulo_contenido, tipo_contenido, segundo_pausado, completado, ultima_reproduccion)
VALUES
    ('user_30', 'vid_010', 'Breaking Bad', 'serie', 1800, true, toTimestamp(now()))
USING TIMESTAMP 2000;

-- 2) Escritura "vieja" (timestamp 1000) llega después, pisando físicamente a la anterior
INSERT INTO plataforma_streaming.historial_reproduccion
    (user_id, video_id, titulo_contenido, tipo_contenido, segundo_pausado, completado, ultima_reproduccion)
VALUES
    ('user_30', 'vid_010', 'Breaking Bad', 'serie', 500, false, toTimestamp(now()))
USING TIMESTAMP 1000;

-- 3) Aunque la escritura con timestamp 1000 fue la última en ejecutarse,
--    debe ganar la de timestamp 2000 (segundo_pausado = 1800, completado = true)
SELECT user_id, video_id, segundo_pausado, completado, WRITETIME(segundo_pausado)
FROM plataforma_streaming.historial_reproduccion
WHERE user_id = 'user_30' AND video_id = 'vid_010';
