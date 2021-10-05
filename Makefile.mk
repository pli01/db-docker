EDITOR=vim
SHELL = /bin/bash
UNAME = $(shell uname -s)

ifeq ($(UNAME),Linux)
include /etc/os-release
endif
ID_U = $(shell id -un)
ID_G = $(shell id -gn)
# enable trace in shell
DEBUG ?= 
#
# Tricks to uppper case
#
UC = $(shell echo '$1' | tr '[:lower:]' '[:upper:]')
#
# docker-compose options
#
DOCKER_USE_TTY := $(shell test -t 1 && echo "-t" )
DC_USE_TTY     := $(shell test -t 1 || echo "-T" )


# global docker prefix
COMPOSE_PROJECT_NAME ?= db

# Default registry
PULL_IMAGE_ENABLE ?= true
DOCKER_REGISTRY   := ghcr.io
DOCKER_REPOSITORY := pli01/db-docker

MYSQL_VERSION ?= 8.0.24
POSTGRES_VERSION ?= 12.6

#
# mysql
#
MYSQL_DATADIR ?= ./data-db-mysql
MYSQL_PORT ?= 3306
MYSQL_NODE ?= localhost:${MYSQL_PORT}
MYSQL_ROOT_PASSWORD ?= changeme
MYSQL_USER ?= dssuser
MYSQL_PASSWORD ?= dsschangeme
MYSQL_DATABASE ?= dss

DC_DSS_DEFAULT_CONF_MYSQL ?= db/docker-compose-db-mysql.yml
DC_DSS_CUSTOM_CONF_MYSQL ?= docker-compose-custom-db-mysql.yml

# detect custom db docker-compose file
DC_DSS_RUN_CONF_DB_MYSQL ?= -f ${DC_DSS_DEFAULT_CONF_MYSQL}
ifneq ("$(wildcard ${DC_DSS_CUSTOM_CONF_MYSQL})","")
DC_DSS_RUN_CONF_DB_MYSQL += -f ${DC_DSS_CUSTOM_CONF_MYSQL}
endif
#
#
# postgresql
#
POSTGRES_DATADIR ?= ./data-db-postgres
POSTGRES_PORT ?= 5432
POSTGRES_NODE ?= localhost:${POSTGRES_PORT}
POSTGRES_PASSWORD ?= changeme
POSTGRES_USER_DSS ?= dbuser
POSTGRES_PASSWORD_DSS ?= dbchangeme
POSTGRES_DATABASE_DSS ?= db

DC_DSS_DEFAULT_CONF_POSTGRES ?= db/docker-compose-db-postgres.yml
DC_DSS_CUSTOM_CONF_POSTGRES ?= docker-compose-custom-db-postgres.yml

# detect custom db docker-compose file
DC_DSS_RUN_CONF_DB_POSTGRES ?= -f ${DC_DSS_DEFAULT_CONF_POSTGRES}
ifneq ("$(wildcard ${DC_DSS_CUSTOM_CONF_POSTGRES})","")
DC_DSS_RUN_CONF_DB_POSTGRES += -f ${DC_DSS_CUSTOM_CONF_POSTGRES}
endif
#
#
# pgadmin
#

PGADMIN_DATADIR ?= data-pgadmin
#PGADMIN_DATADIR ?= ./data-pgadmin
PGADMIN_PORT ?= 80
PGADMIN_DEFAULT_EMAIL ?= noreply@example.org
PGADMIN_DEFAULT_PASSWORD ?= changeme

DC_DSS_DEFAULT_CONF_PGADMIN ?= db/docker-compose-db-postgres.yml
DC_DSS_CUSTOM_CONF_PGADMIN ?= docker-compose-custom-db-postgres.yml

# detect custom db docker-compose file
DC_DSS_RUN_CONF_DB_PGADMIN ?= -f ${DC_DSS_DEFAULT_CONF_PGADMIN}
ifneq ("$(wildcard ${DC_DSS_CUSTOM_CONF_PGADMIN})","")
DC_DSS_RUN_CONF_DB_PGADMIN += -f ${DC_DSS_CUSTOM_CONF_PGADMIN}
endif

