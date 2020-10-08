#!/bin/bash

mkdir $DBNAME
cd $DBNAME
cubrid deletedb $DBNAME

cubrid createdb --db-volume-size=128M --log-volume-size=128M $DBNAME en_US

for i in {0..10}
do
  cubrid tde -n $DBNAME # generate new keys
done

cubrid tde -s $DBNAME
cubrid tde -d 5 $DBNAME
cubrid tde -d 8 $DBNAME
cubrid tde -s $DBNAME    # you can't see 5, 8
cubrid tde -n $DBNAME    # use the smallest emptry slot (5)
cubrid tde -s $DBNAME

cubrid deletedb $DBNAME
