use sql_divakar;

select * from teams;
select * from matches;
select * from players;

/*fetching the player_name and team_name using two
different tables using inner join*/
select p.player_name, t.team_name from players p 
inner join teams t on p.nationality=t.team_name;

--fetching the winners team details by using left join and join . 
select p.player_name, t.team_name, m.winner_team_id from matches m join
players p on p.nationality=(select t.team_name from teams t where t.team_id=m.winner_team_id)
left join teams t on p.nationality=t.team_name where m.winner_team_id in 
(select t.team_id from teams t); 

--fetching the team_name and player_name using right join
select distinct p.player_name, t.team_name, t.team_id from players p 
right join teams t on p.nationality=t.team_name;

--fetching all the attributes from both table using full outer join.
select * from teams t full outer join matches m on t.team_id=m.winner_team_id;  

--using cross join it returns cartesian product
select * from teams t cross join players p where p.nationality=t.team_name;

-- getting player names and match venues they played in.
select p.player_name, m.venue
from players_stats ps
join players p on ps.player_id = p.player_id
join matches m on ps.match_id = m.match_id;


--views

--creating view from 2 tables.
create view players_performance as
select p.player_name,ps.runs_scored from players p
join players_stats ps on p.player_id=ps.player_id;

--fetching the values of the view created.
select * from players_performance;

--creating view from 3 tables.
create view winners_details as select 
p.player_name, t.team_id, m.winner_team_id from matches m
join teams t on t.team_id=m.winner_team_id
join players p on p.nationality=t.team_name;

--fetching the values of the view created.
select * from winners_details;

--dropping the view created.
drop view players_performance;


--sql case

--using join sql case.
select p.player_name,ps.player_id,ps.runs_scored,
case
	when runs_scored >40 then 'the run is more than 40'
	when runs_scored >60 then 'the run is more than 60'
end as runs_scored_details
from players_stats ps join players p on p.player_id=ps.player_id 

--using sql case 
select player_id,runs_scored,
case
	when runs_scored >40 then 'the run is more than 40'
	when runs_scored >60 then 'the run is more than 60'
end as runs_scored_details
from players_stats

--using else in sql case.
select player_id,runs_scored,
case
	when runs_scored >40 then 'the run is more than 40'
	when runs_scored >60 then 'the run is more than 60'
	else 'duck'
end as runs_scored_details
from players_stats


--stored procedure.

--creating a simple stored procedure.
create procedure player_details 
as
begin 
select * from players;
end

--executing the procedure.
exec player_details;

--created a stored procedure and passing parameter to it.
create procedure player_d_nationality
@nationality varchar(20) as 
begin 
select player_name,player_role from players where nationality=@nationality;
end

--executing the procedure and passing the parameter.
exec player_d_nationality @nationality='India';

--dropping a stored procedure statement.
drop procedure player_d_nationality;

--updating the procedure using alter command.
alter procedure player_d_nationality
@player_id int
as
begin
select * from players where player_id=@player_id;
end

--executing the procedure after updating.
exec player_d_nationality @player_id=6;