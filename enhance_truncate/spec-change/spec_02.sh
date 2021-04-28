#!/bin/bash

cubrid createdb --db-volume-size=128M --log-volume-size=128M $DBNAME en_US

cubrid server start $DBNAME

csql -udba -i spec_02.sql $DBNAME

cubrid server stop $DBNAME

# Descripttion:
#   TRUNCATE when there is a FK with ON DELETE RESTRICT, NO ACTION or SET NULL action.

# Expected:
# 1. all statements fail.
#     - the first one: ERROR: Cannot truncate the table due to the primary key referred to on fk_child_a. Try again with CASCADE option.
#     - the others:    ERROR: Cannot cascade truncate because the ON DELETE action of the foreign key (fk_child_a) is not set to CASCADE.
# 2. all select count(*) prints 1

cubrid deletedb $DBNAME
