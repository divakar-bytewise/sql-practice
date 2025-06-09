select * from sys.databases; --command to see the databases present in the system.

use sql_divakar; --If we want to work with our database we have to make use of 'use' command.


--DDL

--1. (create) creating the tables related to cricket and this the table for players.
create table players(player_id int primary key,player_name varchar(20),
player_role varchar(20),dob date,nationality varchar(10));

--creating a teams table.
create table teams(team_id int primary key,team_name varchar(20),coach_name varchar(20));

--creating a matches table.
create table matches(match_id int primary key,team1_id int,team2_id int ,
match_date date,venue varchar(20),winner_team_id int, 
foreign key (team1_id) references teams(team_id),
foreign key (team2_id) references teams(team_id),
foreign key (winner_team_id) references teams(team_id));

--creating players_stats table.
create table players_stats(stat_id  int primary key,match_id int,
player_id int,runs_scored int,balls_faced int,overs_bowled int,wicket_taken int,
foreign key (match_id) references matches(match_id));

--creating umpires table.
create table umpires(match_id int,umpire_id int primary key,umpire_name varchar(20),
umpire_role varchar(20),foreign key (match_id) references matches(match_id));

--creating index for player_name in players table.
create index idx_player_name on players(player_name);



--2. (alter) i have altered the size of the nationality column in players table.
alter table players alter column nationality varchar(20);

--by using alter command adding the CHECK constraint to the players table.
alter table players add constraint check_dob_range check(year(dob) between 1988 and 2010);

--by using alter command adding the NOT NULL constraint to the players table.
alter table players alter column player_name varchar(20) not null;

--i am dropping the umpires table.
alter table umpires drop column umpire_role;

--checking whether the column is deleted or not.
select * from umpires

--adding the column to the umpires_table.
alter table umpires add umpire_role varchar(40);

--updating the values to the column created (umpire_role).
update umpires set umpire_role='main' where umpire_id=1;
update umpires set umpire_role='main' where umpire_id=2;
update umpires set umpire_role='third' where umpire_id=3;
update umpires set umpire_role='reserve' where umpire_id=4;
update umpires set umpire_role='main' where umpire_id=5;

--renaming the table name.
exec sp_rename 'umpires', 'umpires_details';

select * from umpires_details;

-- drop a table
drop table umpires_details;

-- droping an index
drop index idx_player_name on players;

--deleting all the values in a table
truncate table umpires_details;

--inserting values into umpires table.
insert into umpires_details values(101, 1, 'kumar dharmasena', 'main'),
(102, 2, 'marais erasmus', 'main'),
(103, 3, 'aleem dar', 'third'),
(104, 4, 'rod tucker', 'reserve'),
(105, 5, 'paul reiffel', 'main');


--DCL

--switching to master database.
use master;

--creating a user login and password.
create login divakar with password = 'Diva07@.';

--switching to sql_divakar database.
use sql_divakar;

--inside the sql_divakar database creating a user.
create user divakar for login divakar;

--granting access to the new user in the database.
grant update on players to divakar;

--switching to the new user.
exec as user='divakar';

--retrieving the players table data.
select * from players;

--dropping new user. 
drop user divakar;

--switching to master database.
use master;

--dropping new user login in master database.
drop login divakar;

--creating a new role.
create role data_engineer;

--granting the access .
grant update on players to data_engineer;

--assigning the user to particular role.
exec sp_addrolemember 'data_engineer', 'divakar';

--command to view the current user name in the database. 
select user_name();

--command to view the current user name in the server. 
select suser_name(); 

--revoking the access from the new user.
revoke update on players from divakar;


--TCL

--starting transaction.
begin transaction;

--inserting a new data into players.
insert into players values(7,'msd','batsman-wk','1988-04-30','India');

--retrieving the players table data.
select * from players;

--commiting changes permentaly.
commit;

--starting transaction.
begin transaction;

--deleting a row of data.
delete from players where player_id=1;

--retrieving the players table data.
select * from players;

--rollbacking the changes made.
rollback;

--starting transaction.
begin transaction;

--deleting a row of data.
delete from players where player_id=7;

--saving a changes in transaction.
save transaction sp1;

--retrieving the players table data.
select * from players;

--updating the player 1 nationality.
update players set nationality='bharat' where player_id=1;

--rollbacking the changes made.
rollback transaction sp1;

--commiting changes permentaly.
commit;


