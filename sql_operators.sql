use sql_divakar;


--arithmetic operators.

--calculating the strike rate of players.
select player_id, runs_scored, balls_faced, 
(runs_scored*100.0/balls_faced) as strike_rate from players_stats;

--updated extra runs in each match.
select player_id, match_id, runs_scored as 
actual_runs,runs_scored+10 as extra_runs_added from players_stats;

--comparsion operators.

--the players scored more than 40 runs.
select * from players_stats where runs_scored > 40;

--players belong to India.
select * from players where nationality ='India';

--players does not belong to India.
select * from players where nationality !='India';

--the matches held after 2024-03-15.
select * from matches where match_date > '2024-03-15';


--logical operator.

-- getting bowlers from India
select * from players 
where player_role = 'bowler' and nationality = 'India';

-- getting all players who are either batsmen or all-rounders.
select * from players 
where player_role = 'batsman' or player_role = 'all-rounder';

-- getting players who are not from England.
select * from players 
where not nationality = 'England';


--string concatenation operator.

-- combining players names and nationality
select player_name + ' from ' + nationality as player_info
from players;


--predicates & conditions

/*select * from players where nationality is null; 
this will fetch only the value  which is null*/

--getting all the players where there nationality is not null.
select player_id, player_name from players where nationality is not null;

-- players from specific countries.
select * from players where nationality in ('India', 'England');

-- players not from these countries.
select * from players where nationality not in ('India', 'England');

-- players born between 1990 and 2000.
select * from players where dob between '1990-01-01' and '2000-12-31';

-- players who scored between 40 and 80 runs.
select * from players_stats where runs_scored between 40 and 80;

-- players whose names start with 'v'.
select * from players where player_name like 'v%';

-- players whose names end with 'n'.
select * from players where player_name like '%n';

-- names with exactly 5 letters.
select * from players where player_name like '__h%';

-- matches where player stats exist.
select * from matches m 
where exists (select 1 from players_stats p where m.match_id = p.match_id);

-- matches where player stats not exist.
select * from matches m 
where not exists (select 1 from players_stats p where m.match_id = p.match_id);



