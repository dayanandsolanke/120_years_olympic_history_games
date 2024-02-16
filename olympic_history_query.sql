select * from olympics_history;
select * from olympic_history_noc_regions; 


select count(*) from olympics_history;


--- 1) How many plympics games have been held?

select count(distinct games)as total_olympic_games
from olympics_history;
 ---OR
select count(distinct games) from olympics_history;

---Q2) List down all olympic games held so far?
select   distinct year, season,city  from olympics_history order by year ;

---Q3) Mention the total no of nations who participated in each olympics game?
 with all_countries as
        (select games, nr.region
        from olympics_history oh
        join olympic_history_noc_regions nr ON nr.noc = oh.noc
        group by games, nr.region)
    select games, count(1) as total_countries
    from all_countries
    group by games
    order by games;
	
---Q4) Which Sports were just played only once in the olympics.
      with t1 as
          	(select distinct games, sport
          	from olympics_history),
          t2 as
          	(select sport, count(1) as no_of_games
          	from t1
          	group by sport)
      select t2.*, t1.games
      from t2
      join t1 on t1.sport = t2.sport
      where t2.no_of_games = 1
      order by t1.sport;

---Q5) Fetch the total no of sports played in each olympic games.
      with t1 as
      	(select distinct games, sport
      	from olympics_history),
        t2 as
      	(select games, count(1) as no_of_sports
      	from t1
      	group by games)
      select * from t2
      order by no_of_sports desc;
	  