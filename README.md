# IMS_CC_SQL
### Contenedor Docker con MySQL preconfigurado e instalación automática de la base de datos `inventario_db`

Este repositorio forma parte del proyecto final del curso **Cloud Computing**, en el que se diseñó...

## Uso

```bash
docker run -d \
  --name ims_mysql \
  -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=root \
  tebancito/ims_mysql:latest
