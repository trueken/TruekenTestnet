#!/bin/bash

USER_DIR="/home/juane/"
DEVEL_DIR=$USER_DIR"devel/"

#Delete last session logs
rm -f "$DEVEL_DIR"logs/*

#arrancar django
#pero abans matarlo si hi era
killall -9 python
cd "$USER_DIR".virtualenvs/djangodev/
source bin/activate
cd "$DEVEL_DIR"django/trueken
python manage.py runserver > "$DEVEL_DIR"logs/django.log 2> "$DEVEL_DIR"logs/django_2.log &

#arrancar testrpc
#pero abans matar-lo
killall -9 node
testrpc -m "put recycle please music manual hip north clock bread pipe mouse welcome" > "$DEVEL_DIR"logs/testrpc.log &

#arrancar react
killall -9 npm
cd /var/www/html/eclipse/trueken_reactjs/
npm start > "$DEVEL_DIR"logs/react.log &

#truffle
cd /var/www/html/eclipse/trueken/truffle/
truffle migrate > "$DEVEL_DIR"logs/truffle.log 2> "$DEVEL_DIR"logs/truffle_2.log &




