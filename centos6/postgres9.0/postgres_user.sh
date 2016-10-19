#!/bin/bash

__mod_user() {
usermod -G wheel postgres
}

__create_db() {
su --login postgres --command "/usr/pgsql-9.0/bin/postgres -D /var/lib/pgsql/9.0/data -p 5432" &
sleep 10
ps aux 

su --login - postgres --command "psql -c \"CREATE USER dockeruser with CREATEROLE superuser PASSWORD 'password';\""
su --login - postgres --command "psql -c \"CREATE DATABASE dockerdb;\""
su --login - postgres --command "psql -c \"\du;\""
}

# Call functions
__mod_user
__create_db
