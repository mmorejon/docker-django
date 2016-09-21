Django - Docker
====================

Pasos para iniciar un proyecto con Django utilizando Docker dentro del flujo de trabajo. Se utiliza `projectname` para hacer referencia al nombre del projecto.

### Pre requisito

* Tener instalado **Docker**. Si está utilizando Mac OS X instale **Docker Toolbox**.

## Paso Uno - Establecer Estructura.

**_Descargar estructura del proyecto_**

Se descarga el proyecto que contiene la estructura general.
```
git clone https://github.com/mmorejon/docker-django.git projectname
```

**_Eliminar carpeta de Git_**

La carpeta `.git` se elimina para crear un nuevo repositorio.

```
cd projectname
rm -rf .git/
```

**_Crear nuevo repositorio dentro del proyecto_**

Se inicia el control de versiones dentro de la carpeta del proyecto para registrar los cambios.

```
git init
```

## Paso Dos - Crear Imagen de Docker

**_Crear Imagen en Docker_**

Se crea la imagen de Docker para el projecto. La imagen va a contener la instalación de los requerimientos establecidos en el fichero `requirements.txt`.

El fichero `requirements.txt` contiene los requisitos básicos para el inicio y despliegue de una aplicación con Django, si necesita adicionarle nuevos elementos este es un buen momento.

```
docker build -t projectname:1.0 .
```

Siempre que modifique los elementos dentro del fichero `requirements.txt` tiene que repetir este paso.


**_Configurar Docker Compose_**

En el fichero `docker-compose.yml` se modifica el nombre de la imagen que será utilizada. El nombre de la imagen se ha establecido en el paso anterior. La zona que se modifica dentro del fichero es la siguiente:
```
image: projectname:1.0
```

## Paso Tres - Crear Proyecto Django

**_Crear Proyecto_**
Se crea el proyecto utilizando los mismos comandos descritos por el sitio Django.
```
docker-compose run web django-admin startproject projectname .
```

**_Probar el sistema_**
Para probar si el sistema está funcionando correctamente se ejectua el siguiente comando. En el navegador se puede revisar la aplicación en la siguiente dirección `http://<ip-máquina:8000>`. El puerto de salida puede ser configurado en el fichero `docker-compose.yml`.
```
docker-compose up
```

**_Para el sistema_**
Se detiene el sistema de ser necesario para continuar con las configuraciones.
```
Ctrl-C
```

## Paso Cuatro - Crear Aplicación

Para crear una aplicación dentro del proyecto Django se utiliza el siguiente comando:
```
docker-compose run web python manage.py startapp app
```

## Paso Cinco - Crear Usuario

Los usuarios se crean utilizando el mismo comando descrito en la documentación de Django.
```
docker-compose run web python manage.py createsuperuser
```

## Paso Seis - Entorno de Producción

Para utilizar la aplicación en el entorno de producción se debe configurar los siguientes ficheros:

Adicionar al final del fichero `projectname/settings.py` la siguiente línea:

```
STATIC_ROOT = './static/'
```

Adicionar la línea `command: ./run-production.sh` al fichero `docker-compose.yml` quedando de la siguiente forma:

```
web:
  image: projectname:1.0
  command: ./run-production.sh
  volumes:
    - .:/code
  ports:
    - "8000:80"
```

Para finalizar debe modificar el nombre del proyecto `projectname` en el fichero `conf/app.ini`.

### Enlaces relacionados con el tema

* <a target="_blank" href="https://docs.docker.com/compose/django/">Docker Compose con proyectos Django</a>
* <a target="_blank" href="https://docs.djangoproject.com/es/1.9/intro/tutorial01/">Primeros pasos en projectos con Django</a>
