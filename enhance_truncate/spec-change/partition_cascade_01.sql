create table parent (a int primary key) partition by hash(a) partitions 2;
create table child1 (a int, b int primary key, foreign key (a) references parent(a) on delete CASCADE) partition by hash(b) partitions 2;
create table child2 (a int, b int primary key, foreign key (a) references parent(a) on delete CASCADE) partition by hash(b) partitions 2;
create table grand_child1 (b int, c int primary key, foreign key (b) references child1(b) on delete CASCADE) partition by hash(c) partitions 2;
create table grand_child2 (b int, c int primary key, foreign key (b) references child1(b) on delete CASCADE) partition by hash(c) partitions 2;
create table grand_child3 (b int, c int primary key, foreign key (b) references child2(b) on delete CASCADE) partition by hash(c) partitions 2;
create table grand_child4 (b int, c int primary key, foreign key (b) references child2(b) on delete CASCADE) partition by hash(c) partitions 2;
insert into parent values (0), (1), (2), (3);
insert into child1 values (0,0), (1,1), (2,2), (3,3);
insert into child2 values (0,0), (1,1), (2,2), (3,3);
insert into grand_child1 values (0,0), (1,1), (2,2), (3,3);
insert into grand_child2 values (0,0), (1,1), (2,2), (3,3);
insert into grand_child3 values (0,0), (1,1), (2,2), (3,3);
insert into grand_child4 values (0,0), (1,1), (2,2), (3,3);
truncate parent;
select count(*) from parent;
select count(*) from child1;
select count(*) from child2;
select count(*) from grand_child1;
select count(*) from grand_child2;
select count(*) from grand_child3;
select count(*) from grand_child4;
truncate parent cascade;
select count(*) from parent;
select count(*) from child1;
select count(*) from child2;
select count(*) from grand_child1;
select count(*) from grand_child2;
select count(*) from grand_child3;
select count(*) from grand_child4;
drop grand_child1;
drop grand_child2;
drop grand_child3;
drop grand_child4;
drop child1;
drop child2;
drop parent;