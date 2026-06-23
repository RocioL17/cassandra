-- Demo de Replicación: con RF=3 los 3 nodos tienen copia del dato.

CONSISTENCY ALL;
TRACING ON;

SELECT * FROM plataforma_streaming.historial_reproduccion
WHERE user_id = 'user_30' AND video_id = 'vid_010';
-- En el trace ("Source" de cada paso) se ven los 3 nodos del cluster respondiendo,
-- evidencia de que el dato está replicado en todos ellos (RF=3).

TRACING OFF;
