select count(*) from rawchess;

-- first thing for the cleaning creating duplicate table 

create table chess like rawchess;
insert into chess select * from rawchess;

-- look for duplicates values in the dataset

describe chess;

-- no primary key and unique values column 

with chess1 as 
( select * , row_number() over ( partition by id, rated, created_at, last_move_at, turns, victory_status, winner, increment_code, white_id,
black_rating, moves, opening_eco, opening_name, opening_ply) as rownumber from chess) 
select count(*) from chess1 where rownumber > 1;

select * from chess where white_rating = 1630 and black_rating = 1584;	

-- checked with multiple columns and there are duplicate entries found

select count(*) from chess;

-- removing duplicates

CREATE TABLE `chess1` (
  `id` text,
  `rated` text,
  `created_at` double DEFAULT NULL,
  `last_move_at` double DEFAULT NULL,
  `turns` int DEFAULT NULL,
  `victory_status` text,
  `winner` text,
  `increment_code` text,
  `white_id` text,
  `white_rating` int DEFAULT NULL,
  `black_id` text,
  `black_rating` int DEFAULT NULL,
  `moves` text,
  `opening_eco` text,
  `opening_name` text,
  `opening_ply` int DEFAULT NULL,
  `rownumber` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from chess1;

insert into chess1
select * , row_number() over ( partition by id, rated, created_at, last_move_at, turns, victory_status, winner, increment_code, white_id,
black_rating, moves, opening_eco, opening_name, opening_ply) as rownumber from chess;

select count(*) from chess1;

select * from chess1 where rownumber > 1;

delete from chess1 where rownumber > 1;

-- no duplicates 
describe chess1;
-- deleting unwanted columns 

alter table chess1
drop column created_at;

-- Data Exploration 

select count(*), opening_name from chess1
group by opening_name
order by count(*) desc;

select count(*) from chess1;
select * from chess1;


--- how white won 


select victory_status, count(winner) from chess1
where winner = 'black'
group by victory_status
;







