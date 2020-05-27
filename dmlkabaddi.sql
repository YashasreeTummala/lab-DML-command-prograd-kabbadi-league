--DDL COMMANDS
--CREATING MULTIPLE TABLES INCLUDING RELATIONSHIP

create table city1
(id NUMBER(11), 
name varchar(50) NOT NULL,
CONSTRAINT city1_pk PRIMARY KEY(id));

create table referee1
(id NUMBER(11), 
name varchar(50) NOT NULL,
CONSTRAINT referee1_pk PRIMARY KEY(id));

create table innings1
(id NUMBER(11), 
innings_number int NOT NULL,
CONSTRAINT innings1_pk PRIMARY KEY(id));

create table extra_type1
(id NUMBER(11), 
name varchar(50) NOT NULL,
CONSTRAINT extra_type1_pk PRIMARY KEY(id));

create table skill1
(id NUMBER(11), 
name varchar(50) NOT NULL,
CONSTRAINT skill1_pk PRIMARY KEY(id));

create table team1
(id NUMBER(11), 
name varchar(50) NOT NULL,
coach varchar(50) NOT NULL,
home_city NUMBER(11) NOT NULL,
captain NUMBER(11) NOT NULL,
CONSTRAINT team1_pk PRIMARY KEY(id),
CONSTRAINT team1_fk FOREIGN KEY (home_city) REFERENCES city1(id));

create table player1
(id NUMBER(11), 
name varchar(50) NOT NULL ,
country varchar(50) NOT NULL,
skill_id NUMBER(11) NOT NULL,
team_id NUMBER(11) NOT NULL,
CONSTRAINT player1_pk PRIMARY KEY(id),
CONSTRAINT player1_fk1 FOREIGN KEY (skill_id) REFERENCES skill1(id),
CONSTRAINT player1_fk2 FOREIGN KEY (team_id) REFERENCES team1(id));

create table venue1
(id NUMBER(11) NOT NULL, 
stadium_name varchar(50) NOT NULL,
city_id NUMBER(11),
CONSTRAINT venue1_pk PRIMARY KEY(id),
CONSTRAINT venue1_fk FOREIGN KEY (city_id) REFERENCES city1(id));

create table event1
(id NUMBER(11),
innings_id NUMBER(11) NOT NULL,
event_no NUMBER(11) NOT NULL,
raider_id NUMBER(11) NOT NULL,
raider_points NUMBER(11) NOT NULL,
defending_points NUMBER(11) NOT NULL,
clock_in_seconds NUMBER(11) NOT NULL,
team_one_score NUMBER(11) NOT NULL,
team_two_score NUMBER(11) NOT NULL,
CONSTRAINT event1_pk PRIMARY KEY(id),
CONSTRAINT event1_fk1 FOREIGN KEY (innings_id) REFERENCES innings1(id),
CONSTRAINT event1_fk2 FOREIGN KEY (raider_id) REFERENCES player1(id));

create table extra_event1
(id NUMBER(11), 
event_id NUMBER(11) NOT NULL,
extra_type_id NUMBER(11) NOT NULL,
points NUMBER(11) NOT NULL,
scoring_team_id NUMBER(11) NOT NULL,
CONSTRAINT extra_event1_pk PRIMARY KEY(id),
CONSTRAINT extra_event1_fk1 FOREIGN KEY (event_id) REFERENCES event1(id),
CONSTRAINT extra_event1_fk2 FOREIGN KEY (extra_type_id) REFERENCES extra_type1(id),
CONSTRAINT extra_event1_fk3 FOREIGN KEY (scoring_team_id) REFERENCES team1(id));

create table outcome1
(id INT, 
status varchar(100) NOT NULL,
winner_team_id NUMBER(11),
score NUMBER(11),
player_of_match NUMBER(11),
CONSTRAINT outcome1_pk PRIMARY KEY(id),
CONSTRAINT outcome1_fk1 FOREIGN KEY (winner_team_id) REFERENCES team1(id),
CONSTRAINT outcome1_fk2 FOREIGN KEY (player_of_match) REFERENCES player1(id));

create table game1
(id NUMBER(11),
game_date DATE NOT NULL,
team_id_1 NUMBER(11) NOT NULL,
team_id_2 NUMBER(11) NOT NULL,
venue_id NUMBER(11) NOT NULL,
outcome_id NUMBER(11) NOT NULL,
referee_id_1 NUMBER(11) NOT NULL,
referee_id_2 NUMBER(11) NOT NULL,
first_innings_id NUMBER(11) NOT NULL,
second_innings_id NUMBER(11) NOT NULL,
CONSTRAINT game1_pk PRIMARY KEY(id),
CONSTRAINT game1_fk1 FOREIGN KEY (team_id_1) REFERENCES team1(id),
CONSTRAINT game1_fk2 FOREIGN KEY (team_id_2) REFERENCES team1(id),
CONSTRAINT game1_fk3 FOREIGN KEY (venue_id) REFERENCES venue1(id),
CONSTRAINT game1_fk4 FOREIGN KEY (outcome_id) REFERENCES outcome1(id),
CONSTRAINT game1_fk5 FOREIGN KEY (referee_id_1) REFERENCES referee1(id),
CONSTRAINT game1_fk6 FOREIGN KEY (referee_id_2) REFERENCES referee1(id),
CONSTRAINT game1_fk7 FOREIGN KEY (first_innings_id) REFERENCES innings1(id),
CONSTRAINT game1_fk8 FOREIGN KEY (second_innings_id) REFERENCES innings1(id));

-- DML COMMANDS ON SAME TABLES

Insert into city1 values (101, 'HYDERABAD');
Insert into city1 values (102, 'SECUNDERABAD');
Insert into referee1 values (201, 'YASH');
Insert into referee1 values (202, 'SAHI');
Insert into innings1 values (301, 1);
Insert into innings1 values (302, 2);
Insert into extra_type1 values (401, 'Punjabi');
Insert into skill1 values (501, 'Forward');
Insert into team1 values (601, 'Agile', 'Aditya', '101', 4); --101 from city id
Insert into team1 values (602, 'Pro', 'Swara', '102', 7); --101 from city id
Insert into player1 values (701, 'Anil', 'India', 501, 601); -- 501 , 601 are from skill id & team id
Insert into venue1 values (801, 'RGIStadium', 101); -- 101 from city id
Insert into venue1 values (802, 'UppalStadium', 102); -- 102 from city id
Insert into event1 values (901, 301, 1, 701, 10, 6, 60, 20, 15); -- 301 , 701 are from innings id & player id
Insert into extra_event1 values (1001, 901, 401, 20, 601); --901, 401, 601 are from event, extra_type & team respectively
Insert into outcome1 values (2001, 'WON', 601, 20, 701); -- 601, 701 are from team & player
Insert into game1 values (9999, DATE '2020-05-05', 601, 602, 801, 2001, 201, 202, 301, 302);
Insert into game1 values (9998, DATE '2020-05-06', 601, 602, 802, 2001, 201, 202, 301, 302);

Update player1 SET name = 'Dhoni' WHERE id = 701;

alter table extra_event1
Drop COLUMN extra_type_id;

Delete from extra_type1 WHERE id = 401;

alter table game1
Drop Column referee_id_1;
alter table game1
Drop Column referee_id_2; 

Delete from referee1 WHERE name = 'SAHI';

alter table event1
Drop Column raider_id;
alter table outcome1
Drop Column player_of_match;

Delete from player1 WHERE country = 'India';


Delete from outcome1 WHERE score > 25; 

