#!/bin/bash

cubrid createdb --db-volume-size=128M --log-volume-size=128M $DBNAME en_US

cubrid server start $DBNAME

csql -udba -i cascade_04.sql $DBNAME

echo ""
echo "***** Expected: The TRUNCATE succeeds, and following select count(*)s print 0 *****"
echo ""

cubrid server stop $DBNAME

# Descripttion:
#   CASCASDE succeeds with partitioned tables
#   case: A <- B (partitioned) <- C(partitioned)

# Expected:
# 1. The TRUNCATE succeeds, and following select count(*) print 0

cubrid deletedb $DBNAME
