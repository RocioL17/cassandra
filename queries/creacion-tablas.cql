CREATE KEYSPACE plataforma_streaming 
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3};

USE plataforma_streaming;

CREATE TABLE historial_reproduccion (
    user_id text,
    video_id text,
    titulo_contenido text,
    tipo_contenido text,          -- 'pelicula' o 'serie'
    segundo_pausado bigint,       -- En qué segundo se quedó (para el "continuar viendo")
    completado boolean,           -- ¿Terminó de ver el video?
    ultima_reproduccion timestamp,
    PRIMARY KEY (user_id, video_id)
) 