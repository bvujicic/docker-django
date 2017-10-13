FROM python:3.6

ENV PYTHONUNBUFFERED 1

RUN apt-get update && apt-get install -y \
  gettext

RUN mkdir /src

WORKDIR /src

ADD requirements.txt /src/

RUN pip install -r requirements.txt

ADD . /src/

#RUN python3 src/manage.py migrate
