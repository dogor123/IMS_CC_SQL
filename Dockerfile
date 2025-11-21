FROM mysql:8.0

# Variables de entorno necesarias
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=inventario_db

# Copiamos el archivo SQL de inicialización
COPY init.sql /docker-entrypoint-initdb.d/

# Permisos correctos
RUN chmod 644 /docker-entrypoint-initdb.d/init.sql
