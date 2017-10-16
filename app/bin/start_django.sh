#! /bin/bash

python3 /src/bin/check_database.py
while [[ $? != 0 ]] ; do
    sleep 5; echo "*** Waiting for postgres container ..."
    python3 /src/bin/check_database.py
done

echo "Django setup, executing: migrate"
python3 /src/manage.py migrate
echo "Django setup, executing: makemessages"
python3 /src/manage.py makemessages
echo "Django setup, executing: collectstatic"
python3 /src/manage.py collectstatic --noinput -v 3

#python3 /src/manage.py runserver 0.0.0.0:8000
gunicorn dockerexample.wsgi:application -c /src/gunicorn.conf.py --reload