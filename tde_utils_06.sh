#!/bin/bash

TBNAME=test_tbl

mkdir $DBNAME
cd $DBNAME
cubrid deletedb $DBNAME

cubrid createdb --db-volume-size=128M --log-volume-size=128M $DBNAME en_US

ls

cubrid renamedb $DBNAME ${DBNAME}_renamed

ls    # check renamed files including keys file

cubrid deletedb ${DBNAME}_renamed
