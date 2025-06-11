use sql_divakar;


--sql sub_queries.

--getting players who played in matches and won by 'India'.
select * from players 
where player_id in (
select player_id from players_stats 
where match_id in (
select match_id from matches 
where winner_team_id = (
select team_id from teams where team_name = 'India')));

--getting player who scored the highest runs.
select * from players_stats 
where runs_scored = (
select max(runs_scored) from players_stats
);

--getting teams who never won any match.
select * from teams 
where team_id not in (
    select winner_team_id from matches
);


--common table expression.

--using cte to get strike rate for each player.
with player_strike_rate as (
select player_id, runs_scored, balls_faced, 
(runs_scored * 100.0 / balls_faced) as strike_rate
from players_stats)
select * from player_strike_rate 
where strike_rate > 130;

--cte to get match results with team names.
with match_result as (
select m.match_id, t.team_name as winner
from matches m
join teams t on m.winner_team_id = t.team_id)
select * from match_result;
