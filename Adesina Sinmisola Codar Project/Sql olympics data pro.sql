-- creating database
create database if not exists Olympics;
use Olympics;
-- creating tables in the database
create table if not exists Olympics_history(
							id int,
                            Name varchar(255),
                            Sex varchar(255),
                            Age varchar(255),
                            Height varchar(255),
                            Weight varchar(255),
                            Team varchar(255),
                            NOC varchar(255),
                            Games varchar(255),
                            year int,
                            season varchar(255),
                            city varchar(255),
                            sport varchar(255),
                            event varchar(255),
                            medal varchar(255)
);
                       

create table if not exists olympics_history_noc_region(
							NOC varchar(255) primary key,
                            region varchar(255),
                            notes varchar(255)
);
-- setting fk
alter table olympics_history
add constraint foreign key (NOC) references olympics_history_noc_region(NOC);

-- Analysis questions
-- 1. How many olympics games have been held
select count(distinct games) as 'Number of olympics games'
from olympics_history;

-- 2. list down all the olympic games held
select distinct games
from olympics_history;

-- 3. Mention the total number of nations participated in each olympic game
select count(region) as "Olympic nations"
from olympics_history_noc_region;

-- 4. Which year saw the highest and lowest no. of countries participating in olympics
select year, count(distinct region) as "countries"
from olympics_history as OH
inner join olympics_history_noc_region as reg on OH.NOC=reg.NOC
group by year
order by count(distinct region) asc;

-- 5. which nation has participated in all the olympics games
select  count(distinct games), reg.region
from olympics_history_noc_region as reg 
inner join olympics_history as OH on reg.NOC=OH.NOC
group by reg.region
having count(distinct games) = "51"
order by count(distinct games) desc;


-- 6. identify the sport which was played in all summer olympics
select count(season),sport
from olympics_history
where season="summer"
group by sport
order by count(season) desc;


-- 7.	Which Sports were just played only once in the olympics?
select sport,count(distinct games)
from olympics_history
group by sport
order by count(games);

-- 8.	Fetch the total no of sports played in each olympic games.
select count(distinct sport) as "Number of sports played",games
from olympics_history
group by games;

-- 9.	Fetch details of the oldest athletes to win a gold medal.
select id,name,age,medal
from olympics_history
where medal='gold' and age not like "NA"
order by age desc;


-- 10.	Find the Ratio of male and female athletes participated in all olympic games.
use olympics;
select count(distinct name),sex
from olympics_history
group by sex; 



-- 11.	Fetch the top 5 athletes who have won the most gold medals.
select name,count(medal) as "Number of Medals won"
from olympics_history
where medal="gold"
group by name
order by count(medal) desc
limit 5;


-- 12.	Fetch the top 5 athletes who have won the most medals (gold/silver/bronze)
select name,count(medal)
from olympics_history
where medal not like "NA"
group by name
order by count(medal) desc;

-- 13.	Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won.
select OHNR.region,count(OH.medal) as 'number of medal won'
from olympics_history_noc_region as OHNR
inner join olympics_history as OH on OHNR.NOC=OH.NOC
where medal not like "NA"
group by OHNR.region
order by count(OH.medal) desc
limit 5;

use olympics;
-- 14.	List down total gold, silver and bronze medals won by each country.
select OHNR.region,count(OH.medal) as "Number of gold medal"
from olympics_history_noc_region as OHNR
inner join olympics_history as OH on OHNR.NOC=OH.NOC
where medal ="Gold" 
group by region;

select OHNR.region,count(OH.medal) as "Number of silver medal"
from olympics_history_noc_region as OHNR
inner join olympics_history as OH on OHNR.NOC=OH.NOC
where medal ="Silver" 
group by region;

select OHNR.region,count(OH.medal) as "Number of Bronze medal"
from olympics_history_noc_region as OHNR
inner join olympics_history as OH on OHNR.NOC=OH.NOC
where medal ="Bronze" 
group by region;

-- 15.	List down total gold, silver and bronze medals won by each country corresponding to each olympic games.
select OHNR.region,count(OH.medal) as "Number of gold medals",OH.Games 
from olympics_history_noc_region as OHNR
inner join olympics_history as OH on OHNR.NOC=OH.NOC
where medal ="Gold" 
group by OHNR.region,OH.games;

select OHNR.region,count(OH.medal)as "Number of Silver medal",OH.Games 
from olympics_history_noc_region as OHNR
inner join olympics_history as OH on OHNR.NOC=OH.NOC
where medal ="Silver" 
group by OHNR.region,OH.games;

select OHNR.region,count(OH.medal)as "Number of Bronze medal",OH.Games 
from olympics_history_noc_region as OHNR
inner join olympics_history as OH on OHNR.NOC=OH.NOC
where medal ="Bronze" 
group by OHNR.region,OH.games;


-- 16.	Identify which country won the most gold, most silver and most bronze medals in each olympic games.
select OHNR.region,OH.games,count(OH.medal) as "Number of Gold medals"
from olympics_history as OH
inner join olympics_history_noc_region as OHNR on OH.NOC=OHNR.NOC
where medal="Gold"
group by OHNR.region,OH.games
order by count(OH.medal) desc;

select OHNR.region,OH.games,count(OH.medal) as "Number of Silver medals"
from olympics_history as OH
inner join olympics_history_noc_region as OHNR on OH.NOC=OHNR.NOC
where medal="Silver"
group by OHNR.region,OH.games
order by count(OH.medal) desc;

select OHNR.region,OH.games,count(OH.medal) as "Number of Bronze medals"
from olympics_history as OH
inner join olympics_history_noc_region as OHNR on OH.NOC=OHNR.NOC
where medal="Bronze"
group by OHNR.region,OH.games
order by count(OH.medal) desc;


-- 17.	Identify which country won the most gold, most silver, most bronze medals and the most medals in each olympic games.
select OHNR.region,OH.games,count(OH.medal) as "Number of Gold medals"
from olympics_history as OH
inner join olympics_history_noc_region as OHNR on OH.NOC=OHNR.NOC
where medal="Gold"
group by OHNR.region,OH.games
order by count(OH.medal) desc;

select OHNR.region,OH.games,count(OH.medal) as "Number of Silver medals"
from olympics_history as OH
inner join olympics_history_noc_region as OHNR on OH.NOC=OHNR.NOC
where medal="Silver"
group by OHNR.region,OH.games
order by count(OH.medal) desc;

select OHNR.region,OH.games,count(OH.medal) as "Number of Bronze medals"
from olympics_history as OH
inner join olympics_history_noc_region as OHNR on OH.NOC=OHNR.NOC
where medal="Bronze"
group by OHNR.region,OH.games
order by count(OH.medal) desc;

-- Country that won most medals
select OHN.region, count(OH.medal) as "Number of medal",OH.games
from olympics_history as OH
inner join olympics_history_noc_region as OHN on OH.NOC=OHN.NOC
where medal not like "NA"
group by OH.games, OHN.region
order by count(OH.medal) desc;

-- 18.	Which countries have never won gold medal but have won silver/bronze medals?
select OHN.region, OH.medal ,OH.games
from olympics_history as OH
inner join olympics_history_noc_region as OHN on OH.NOC=OHN.NOC;




-- 19.	In which Sport/event, India has won highest medals.
select OHN.region,count(OH.medal),OH.sport,OH.event
from olympics_history as OH
inner join olympics_history_noc_region as OHN on OH.NOC=OHN.NOC
where OH.medal not like "NA" and OHN.region ="India"
group by OH.sport,OH.event,OHN.region;

-- 20.	Break down all olympic games where india won medal for Hockey and how many medals in each olympic games.
select OHN.region,count(OH.medal) as "Number of medals",OH.games,OH.sport
from olympics_history as OH
inner join olympics_history_noc_region as OHN on OH.NOC=OHN.NOC
where OHN.region="India" and OH.sport="Hockey" and OH.medal not like "NA"
group by games;


 
