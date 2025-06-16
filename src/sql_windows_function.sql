--using lag lead for previous and next details .
select player_id, runs_scored,
lag(runs_scored) over (order by player_id) as prev_score,
lead(runs_scored) over (order by player_id) as next_score
from players_stats;

--command to see the schema of a table.
exec sp_help 'players';

--using the rank function gave rank for the players.
select player_id,runs_scored, 
rank() over (order by player_id) as rank from players_stats;

--using ntile to divide the group by 3.
select player_id, runs_scored,
ntile(3) over (order by runs_scored desc) as performance_bucket
from players_stats;

--using dense rank function and gave rank for the players.
select player_id, runs_scored,
dense_rank() over (order by runs_scored desc) as dense_player_rank
from players_stats;

--using row_number to give numbers to the row.
select player_id, runs_scored,
row_number() over (order by runs_scored desc) as rank_by_runs
from players_stats;

--finding the players count in each country.
select nationality, count(*) over(partition by nationality) 
as total_players from players;

