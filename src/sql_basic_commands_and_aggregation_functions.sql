create database sql_divakar; --creating a database to work with mysql.

select * from sys.databases; --command to see the databases present in the system.

use sql_divakar; --If we want to work with our database we have to make use of 'use' command.

--creating the tables related to cricket and this the table for players.
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

--inserting values into players table.
insert into players values(1, 'virat kohli', 'batsman', '1988-11-05', 'India'),
(2, 'jasprit bumrah', 'bowler', '1993-12-06', 'India'),
(3, 'ben stokes', 'all-rounder', '1991-06-04', 'England'),
(4, 'joe root', 'batsman', '1990-12-30', 'England'),
(5, 'rashid khan', 'bowler', '1998-09-20', 'Afghanistan');

--inserting values into teams table.
insert into teams values(1, 'India', 'rahul dravid'),
(2, 'England', 'brendon mccullum'),
(3, 'Australia', 'andrew mcdonald'),
(4, 'Pakistan', 'grant bradburn'),
(5, 'Afghanistan', 'jonathan trott');

--inserting values into matches table.
insert into matches values(101, 1, 2, '2024-03-10', 'mumbai', 1),
(102, 3, 4, '2024-03-12', 'sydney', 4),
(103, 2, 5, '2024-03-14', 'london', 2),
(104, 1, 3, '2024-03-16', 'delhi', 3),
(105, 4, 5, '2024-03-18', 'lahore', 5);

--inserting values into players_stats table.
insert into players_stats values(1, 101, 1, 75, 50, 0, 0),
(2, 101, 2, 10, 8, 10, 2),
(3, 102, 3, 45, 35, 6, 1),
(4, 103, 5, 5, 10, 8, 3),
(5, 105, 4, 80, 60, 0, 0);


--inserting values into umpires table.
insert into umpires values(101, 1, 'kumar dharmasena', 'main'),
(102, 2, 'marais erasmus', 'main'),
(103, 3, 'aleem dar', 'third'),
(104, 4, 'rod tucker', 'reserve'),
(105, 5, 'paul reiffel', 'main');

--i have altered the size of the nationality column in players table.
alter table players alter column nationality varchar(20);

--to display all the values in the table we make use of select *.
select * from players;
select * from teams;
select * from matches;
select * from players_stats;
select * from umpires;

--by using alter command adding the CHECK constraint to the players table.
alter table players add constraint check_dob_range check(year(dob) between 1988 and 2010);

--the command used to see the tables in the database.
select * from sys.tables;

--by using alter command adding the NOT NULL constraint to the players table.
alter table players alter column player_name varchar(20) not null;

--creating index for player_name in players table.
create index idx_player_name on players(player_name);

--i am dropping the umpires table.
drop table umpires;


--aggergation function.


--adding runs scored by all players.
select sum(runs_scored) as total_runs from players_stats;

--calculating avg - runs scored by the players. 
select avg(runs_scored) as average_runs from players_stats;

--counting the total_players.
select count(*) as total_players from players;

--calculating min - runs scored by the players.
select min(runs_scored) as minimum_runs from players_stats;

--calculating max - runs scored by the players.
select max(runs_scored) as maximum_runs from players_stats;


--sql clauses.


--using where clause to retrive only the Indian players.
select * from players where nationality = 'India';

--using group by and having clause to group the players by the play_id.
select player_id, sum(runs_scored) as total_runs
from players_stats
group by player_id having sum(runs_scored)>40;

select p.nationality,count(*) as total_no_players
from players p group by p.nationality;

--using having clause
select p.nationality,count(*) as total_no_players
from players p group by p.nationality
having count(*)>1;

--using order by clause.
select player_name, nationality,dob from players order by dob desc;

--instead of limit we can usethe top in ssms.
select top 3 * from players_stats;

--using 'in' clause.
select player_name from players where nationality in ('India','England');