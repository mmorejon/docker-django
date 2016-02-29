#!/bin/bash

python manage.py migrate
python manage.py collectstatic --noinput
python manage.py compilemessages

uwsgi --ini conf/app.ini

nginx
