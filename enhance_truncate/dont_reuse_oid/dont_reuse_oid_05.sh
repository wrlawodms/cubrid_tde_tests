#!/bin/bash

cubrid createdb --db-volume-size=128M --log-volume-size=128M $DBNAME en_US

csql -udba -S -c "create table tbl (a int primary key) dont_reuse_oid" $DBNAME
csql -udba -S -c "create table tbl2 (a int foreign key references tbl(a) on delete cascade) dont_reuse_oid" $DBNAME
csql -udba -S -c "insert into tbl values (0)" $DBNAME
csql -udba -S -c "insert into tbl2 values (0)" $DBNAME

VFIDS_BEFORE=`cubrid diagdb -d1 $DBNAME | grep -B 13 "tbl" | grep vfid` 

csql -udba -S -i dont_reuse_oid_05.sql $DBNAME

VFIDS_AFTER=`cubrid diagdb -d1 $DBNAME | grep -B 13 "tbl" | grep vfid`

# Expected 1: these two below have to be same"
echo "== Expected 1: these two below have to be same =="
echo "Previous VFIDs: $VFIDS_BEFORE" 
echo "Current VFIDs: $VFIDS_AFTER"

echo "== Expected 2: only one record : a=0 =="
csql -udba -S -c "select * from tbl" $DBNAME # Expected 2: only one record : a=0

csql -udba -S -c "create table tbl3 under tbl dont_reuse_oid" $DBNAME # In this case, index is not dropped.
csql -udba -S -i reuse_oid_05.sql $DBNAME

echo "== Expected 3: only one record : a=0 =="
csql -udba -S -c "select * from tbl" $DBNAME # Expected 3: only one record : a=0

# Descripttion:
# Check if it is consistent after ROLLBACK. The heap and btree have to be the same as before ROLLBACK 

# Expected:
# 3 epxected reults. See comments above

cubrid deletedb $DBNAME
