#!/bin/bash

python manage.py migrate
python manage.py collectstatic --noinput

uwsgi --ini conf/app.ini

nginx
