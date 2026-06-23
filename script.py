import time
import random
from datetime import datetime
from cassandra.cluster import Cluster
from cassandra import ConsistencyLevel
from cassandra.query import SimpleStatement

# Conexión al clúster local de 3 nodos
CONTACT_POINTS = ['127.0.0.1']

print("Conectando al clúster de Cassandra (Plataforma Streaming)...")
cluster = Cluster(CONTACT_POINTS, port=9042)
session = cluster.connect('plataforma_streaming')

# Consulta de inserción/actualización (En Cassandra, INSERT y UPDATE hacen lo mismo si la clave ya existe)
query = """
    INSERT INTO historial_reproduccion (user_id, video_id, titulo_contenido, tipo_contenido, segundo_pausado, completado, ultima_reproduccion)
    VALUES (%s, %s, %s, %s, %s, %s, %s)
"""

statement = SimpleStatement(query, consistency_level=ConsistencyLevel.ONE)

# Datos simulados para la plataforma de streaming
usuario_demo = "user_streaming_argentina"
catalogo = [
    {"id": "vid_breaking_01", "titulo": "Breaking Bad S01E01", "tipo": "serie"},
    {"id": "vid_batman_2022", "titulo": "The Batman", "tipo": "pelicula"},
    {"id": "vid_interstellar", "titulo": "Interstellar", "tipo": "pelicula"},
    {"id": "vid_office_05", "titulo": "The Office S03E05", "tipo": "serie"}
]

print(f"\n Iniciando telemetría de reproducción para: {usuario_demo}")
print("Simulando actualización del reproductor de video cada 1.5 segundos...\n")

contador = 0
# Simulamos que el usuario está viendo un contenido aleatorio y avanza en la reproducción
contenido_actual = random.choice(catalogo)
segundo_actual = random.randint(0, 600) # Empieza en un minuto aleatorio

try:
    while True:
        segundo_actual += random.randint(5, 15) # Avanza unos segundos en la reproducción
        completado = segundo_actual > 5400      # Si pasa de hora y media, se marca como completado
        ahora = datetime.now()

        try:
            session.execute(statement, (
                usuario_demo, 
                contenido_actual["id"], 
                contenido_actual["titulo"], 
                contenido_actual["tipo"], 
                segundo_actual, 
                completado, 
                ahora
            ))
            contador += 1
            print(f"[{contador}]  {contenido_actual['titulo']} -> Reproduciendo en segundo: {segundo_actual}s. (Guardado en DB)")
            
            # Si el video termina o al azar, cambia de película/serie
            if completado or random.random() < 0.05:
                contenido_actual = random.choice(catalogo)
                segundo_actual = random.randint(0, 100)
                print(f"\n🔄 El usuario cambió de contenido...\n")

        except Exception as e:
            print(f"Error temporal en la base de datos: {e}")
        
        time.sleep(1.5)

except KeyboardInterrupt:
    print("\nSimulación de streaming finalizada.")
finally:
    cluster.shutdown()