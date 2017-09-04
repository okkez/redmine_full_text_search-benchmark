#!/bin/bash

hosts="redmine-mariadb redmine-mroonga redmine-postgresql redmine-pgroonga"

for host in ${hosts}; do
    ./run.rb --host ${host} --queries query.txt --username=admin --password=admin
done

echo done
