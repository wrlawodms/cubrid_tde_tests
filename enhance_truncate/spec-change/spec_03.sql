
create table parent (a int primary key);
create table child (a int, b int, foreign key (a) references parent(a) on delete CASCADE);
insert into parent values(3);
truncate parent;
select count(*) from parent;
drop child;
drop parent;

create table parent (a int primary key);
create table child (a int, b int, foreign key (a) references parent(a) on delete CASCADE);
insert into parent values(3);
truncate parent cascade;
select count(*) from parent;
drop child;
drop parent;