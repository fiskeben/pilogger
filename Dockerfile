FROM phusion/passenger-ruby23:0.9.21

MAINTAINER Ricco Førgaard "ricco@fiskeben.dk"

RUN rm -f /etc/service/nginx/down
RUN rm /etc/nginx/sites-enabled/default
ADD nginx.conf /etc/nginx/sites-enabled/webapp.conf
ADD env-vars.conf /etc/nginx/main.d/
RUN mkdir -p /home/app/webapp

USER app

WORKDIR /home/app/webapp
COPY . /home/app/webapp
RUN bundle install

USER root
