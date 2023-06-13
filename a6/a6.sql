use epl;

-- q4

select match_number, home_team, away_team 
	from matches 
    where match_day = 1 and home_goals_full > away_goals_full;

-- q5

select team_name, count(manager_name) as num_managers 
	from team_managers 
    group by team_name 
    having num_managers > 1;

-- q6

select manager_name, count(team_name) as num_teams 
	from team_managers 
    group by manager_name 
    having num_teams > 1;

-- q7

select manager_name, team_name, SUM(home_goals_full) as num_goals 
	from team_managers as tm 
		join matches 
        on tm.team_name = matches.home_team 
	where tm.status='Active' 
    group by manager_name, team_name 
    order by num_goals desc;

-- q8

select manager_name, count(*) as num_matches_won 
	from 
		(select * 
			from team_managers as tm 
				join matches 
                on tm.team_name = matches.home_team 
			where tm.status='Active' and home_goals_full > away_goals_full 
		union 
        select * 
			from team_managers as tm 
				join matches 
                on tm.team_name = matches.away_team 
			where tm.status='Active' and away_goals_full > home_goals_full) 
		as matches_won 
    group by manager_name 
    order by num_matches_won desc;

-- q9

select venue 
	from 
		(select venue, SUM(home_goals_full + away_goals_full) as goals_scored 
			from teams 
				join matches 
                on teams.team_name = matches.home_team 
			group by venue) 
		as stadium_goals 
	order by goals_scored desc 
    limit 1;

-- q10

select team_name, count(*) as num_matches_drawn 
	from teams 
		join matches 
        on teams.team_name = matches.home_team 
			or teams.team_name = matches.away_team 
	where home_goals_full = away_goals_full 
    group by team_name;

-- q11

select team_name, count(*) as num_clean_sheets 
	from 
		(select * 
			from teams 
				join matches 
                on teams.team_name = matches.home_team 
			where away_goals_full = 0 
		union 
        select * 
			from teams 
				join matches 
                on teams.team_name = matches.away_team 
			where home_goals_full = 0) 
		as clean_sheets 
	group by team_name 
    order by num_clean_sheets desc 
    limit 5;

-- q12

select * 
	from matches 
    where `date` >= '2017-12-25' 
		and `date` <= '2018-01-03' 
        and home_goals_full >= 3;

-- q13

select * 
	from matches 
	where 
		(home_goals_half > away_goals_half and away_goals_full > home_goals_full) 
		or 
        (away_goals_half > home_goals_half and home_goals_full > away_goals_full);

-- q14

select team_name 
	from 
		(select team_name, count(*) as num_matches_won 
			from 
				(select * 
					from teams 
						join matches 
                        on teams.team_name = matches.home_team 
					where home_goals_full > away_goals_full 
				union 
                select * 
					from teams 
						join matches 
                        on teams.team_name = matches.away_team 
					where away_goals_full > home_goals_full) 
				as matches_won 
			group by team_name) 
		as team_matches_won 
	order by num_matches_won desc 
    limit 5;

-- q15

with home_stats as (select team_name, avg(home_goals_full) as scored_home, avg(away_goals_full) as conceded_home from teams join matches on teams.team_name = matches.home_team group by team_name),
	 away_stats as (select team_name, avg(away_goals_full) as scored_away, avg(home_goals_full) as conceded_away from teams join matches on teams.team_name = matches.away_team group by team_name)
select * from home_stats join away_stats using(team_name);
