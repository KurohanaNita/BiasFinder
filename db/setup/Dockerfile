# Use Bitnami's Postgres 17 image as the base
FROM bitnami/postgresql:17

# Copy your SQL scripts into the directory that Postgres checks on first run
# Rename or prefix them with numbers so they run in the desired order
COPY ./init.sql /docker-entrypoint-initdb.d/1_init.sql
COPY ./triggers.sql /docker-entrypoint-initdb.d/2_triggers.sql
COPY ./views.sql /docker-entrypoint-initdb.d/3_views.sql
COPY ./data_import/Insert_group_ATZ.sql /docker-entrypoint-initdb.d/4_insert_group_ATZ.sql
COPY ./data_import/Insert_group_BLP.sql /docker-entrypoint-initdb.d/5_insert_group_BLP.sql
COPY ./insert_users.sql /docker-entrypoint-initdb.d/insert_users.sql

# Expose Postgres port (so you can connect from outside containers)
EXPOSE 5432

# The parent image (bitnami/postgresql:17) already defines its ENTRYPOINT
# so you usually don't need to override it here. That entrypoint will:
# 1) Initialize a new database if none exists
# 2) Run *.sql files found in /docker-entrypoint-initdb.d/
# 3) Start the Postgres server