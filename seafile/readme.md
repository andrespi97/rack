kubectl create ns seafile

kubectl create secret generic seafile-secret --namespace seafile \
--from-literal=JWT_PRIVATE_KEY='<required>' \
--from-literal=SEAFILE_MYSQL_DB_HOST='asdf' \
--from-literal=SEAFILE_MYSQL_DB_USER='asdf' \
--from-literal=SEAFILE_MYSQL_DB_PASSWORD='<required>' \
--from-literal=INIT_SEAFILE_ADMIN_EMAIL='<required>' \
--from-literal=INIT_SEAFILE_ADMIN_PASSWORD='<required>' \
--from-literal=INIT_SEAFILE_MYSQL_ROOT_PASSWORD='<required>' \
--from-literal=REDIS_PASSWORD='' \