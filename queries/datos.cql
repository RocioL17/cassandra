-- 1. Un usuario que dejó una película a la mitad (para probar el "continuar viendo")
INSERT INTO plataforma_streaming.historial_reproduccion (user_id, video_id, titulo_contenido, tipo_contenido, segundo_pausado, completado, ultima_reproduccion)
VALUES ('user_001', 'vid_matrix_01', 'The Matrix', 'pelicula', 3420, false, '2026-06-23 14:30:00-0300');

-- 2. El mismo usuario que ya terminó de ver un capítulo de una serie
INSERT INTO plataforma_streaming.historial_reproduccion (user_id, video_id, titulo_contenido, tipo_contenido, segundo_pausado, completado, ultima_reproduccion)
VALUES ('user_001', 'vid_breakingbad_s01e01', 'Breaking Bad - S01E01', 'serie', 2900, true, '2026-06-22 21:15:00-0300');

-- 3. Otro usuario que está viendo una serie en maratón
INSERT INTO plataforma_streaming.historial_reproduccion (user_id, video_id, titulo_contenido, tipo_contenido, segundo_pausado, completado, ultima_reproduccion)
VALUES ('user_002', 'vid_strangerthings_s04e01', 'Stranger Things - S04E01', 'serie', 120, false, '2026-06-23 15:00:00-0300');

-- 4. Un tercer usuario que completó una película entera
INSERT INTO plataforma_streaming.historial_reproduccion (user_id, video_id, titulo_contenido, tipo_contenido, segundo_pausado, completado, ultima_reproduccion)
VALUES ('user_003', 'vid_interstellar_01', 'Interstellar', 'pelicula', 10140, true, '2026-06-20 18:00:00-0300');