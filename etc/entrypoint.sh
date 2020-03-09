#!/bin/bash

echo "127.0.0.1   php-server" >> /etc/hosts

exec /usr/bin/supervisord



