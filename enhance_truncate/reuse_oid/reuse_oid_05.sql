;auto off
truncate tbl cascade;
insert into tbl values (1);
truncate tbl cascade;
insert into tbl values (2);
rollback;
truncate tbl cascade;
insert into tbl values (3);
truncate tbl cascade;
insert into tbl values (4);
truncate tbl cascade;
insert into tbl values (5);
rollback;
