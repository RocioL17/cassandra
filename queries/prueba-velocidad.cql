USE plataforma_streaming;

INSERT INTO plataforma_streaming.historial_reproduccion (user_id, video_id, titulo_contenido, tipo_contenido, segundo_pausado, completado, ultima_reproduccion)
VALUES ('user_30', 'vid_010', 'Breaking Bad', 'serie', 3600, false, '2026-06-24 22:00:00');

INSERT INTO plataforma_streaming.historial_reproduccion (user_id, video_id, titulo_contenido, tipo_contenido, segundo_pausado, completado, ultima_reproduccion)
VALUES ('user_30', 'vid_011', 'Inception', 'pelicula', 1200, false, '2026-06-24 23:00:00');

TRACING ON;

SELECT * FROM plataforma_streaming.historial_reproduccion
WHERE user_id = 'user_30' AND video_id = 'vid_010';

TRACING OFF;
