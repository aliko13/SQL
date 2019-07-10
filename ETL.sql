-- Author: Ali Huseynov D14122782
/* Golf DB 1 and DB 2*/
drop table Results1;
drop table Results2;
drop table Players1;
drop table Players2;
drop table Team1;
drop table Team2;
drop table tournament1;
drop table tournament2;


drop table Player_Dim;
drop table Team_Dim;
drop table Tournament_Dim;
drop table Date_Dim;
drop table Fact_Results_Dim;

drop table Team_Stage;
drop table Player_Stage;
drop table Tournament_Stage;
drop table Date_Stage;
drop table Fact_Stage;

drop sequence Team_Stage_seq;
drop sequence Player_Stage_seq;
drop sequence Tournament_Stage_seq;
drop sequence Date_Stage_seq;
drop sequence Fact_Stage_seq;

Create Table Team1(
Team_id integer primary key,
Team_name varchar(100)
);

Create Table Team2(
Team_id integer primary key,
Team_name varchar(100)
);

Create Table Players1(
p_id integer primary key,
p_name varchar(50),
p_sname varchar(50),
team_id integer,
constraint fk_team_1 foreign key (team_id) references team1
);

Create Table Players2(
p_id integer primary key,
p_name varchar(50),
p_sname varchar(50),
team_id integer,
constraint fk_team_2 foreign key (team_id) references team2
);

Create Table Tournament1(
T_id integer primary key,
t_descriprion varchar(100),
d_id integer,
t_date date,
Total_price float
);

Create Table Tournament2(
T_id integer primary key,
t_descriprion varchar(100),
d_id integer,
t_date date,
Total_price float
);

Create Table Results1(
t_id integer,
p_id integer,
d_id integer,
rank integer,
price float,
CONSTRAINT  FK_player1 FOREIGN KEY (p_id) REFERENCES Players1,
CONSTRAINT  FK_tournament1 FOREIGN KEY (t_id) REFERENCES Tournament1,
CONSTRAINT  FKd_tournament1 FOREIGN KEY (d_id) REFERENCES Tournament1,
CONSTRAINT PK_Results1 PRIMARY KEY (t_id,p_id,d_id)
);

Create Table Results2(
t_id integer,
p_id integer,
d_id integer,
rank integer,
price float,
CONSTRAINT  FK_player2 FOREIGN KEY (p_id) REFERENCES Players2,
CONSTRAINT  FK_tournament2 FOREIGN KEY (t_id) REFERENCES Tournament2,
CONSTRAINT  FKd_tournament2 FOREIGN KEY (d_id) REFERENCES Tournament2,
CONSTRAINT PK_Results2 PRIMARY KEY (t_id,p_id,d_id)
);


/* data */
INSERT INTO TEAM1 (TEAM_ID, TEAM_NAME) VALUES (1, 'USA');
INSERT INTO TEAM1 (TEAM_ID, TEAM_NAME) VALUES (2, 'AUSTRALIA');
INSERT INTO TEAM1 (TEAM_ID, TEAM_NAME) VALUES (3, 'UK');
INSERT INTO TEAM1 (TEAM_ID, TEAM_NAME) VALUES (4, 'IRELAND');

INSERT INTO TEAM2 (TEAM_ID, TEAM_NAME) VALUES (1, 'UK');
INSERT INTO TEAM2 (TEAM_ID, TEAM_NAME) VALUES (2, 'IRELAND');
INSERT INTO TEAM2 (TEAM_ID, TEAM_NAME) VALUES (3, 'USA');
INSERT INTO TEAM2 (TEAM_ID, TEAM_NAME) VALUES (4, 'ITALY');

INSERT INTO PLAYERS1 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (1, 'Tiger', 'Woods', 1);
INSERT INTO PLAYERS1 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (2, 'Mary', 'Smith', 2);
INSERT INTO PLAYERS1 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (3, 'Mark', 'Deegan', 2);
INSERT INTO PLAYERS1 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (4, 'James', 'Bryan', 3);
INSERT INTO PLAYERS1 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (5, 'John', 'McDonald', 1);
INSERT INTO PLAYERS1 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (6, 'Mario', 'Baggio', 1);

INSERT INTO PLAYERS2 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (2, 'Tiger', 'Woods', 3);
INSERT INTO PLAYERS2 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (1, 'John', 'McDonald', 3);
INSERT INTO PLAYERS2 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (3, 'Jim', 'Burke', 3);
INSERT INTO PLAYERS2 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (4, 'Paul', 'Bin', 3);
INSERT INTO PLAYERS2 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (5, 'Peter', 'Flynn', 3);
INSERT INTO PLAYERS2 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (6, 'Martha', 'Ross', 4);


INSERT INTO TOURNAMENT1 (T_ID, T_DESCRIPRION, d_id, TOTAL_PRICE,t_date) VALUES (1, 'US open', 1, 1700000,'01-jan-2014');
INSERT INTO TOURNAMENT1 (T_ID, T_DESCRIPRION, d_id, TOTAL_PRICE,t_date) VALUES (2, 'British Open', 2, 7000000,'01-apr-2014');
INSERT INTO TOURNAMENT1 (T_ID, T_DESCRIPRION, d_id, TOTAL_PRICE,t_date) VALUES (3, 'Italian Open', 3, 2000000,'11-mar-2014');
INSERT INTO TOURNAMENT1 (T_ID, T_DESCRIPRION, d_id, TOTAL_PRICE,t_date) VALUES (4, 'Irish Open', 4, 300000,'21-jul-2014');

INSERT INTO TOURNAMENT2 (T_ID, T_DESCRIPRION, d_id, TOTAL_PRICE,t_date) VALUES (1, 'Dutch open', 1, 1700000,'22-nov-2014');
INSERT INTO TOURNAMENT2 (T_ID, T_DESCRIPRION, d_id, TOTAL_PRICE,t_date) VALUES (2, 'French Open', 2, 7000000,'17-dec-2014');
INSERT INTO TOURNAMENT2 (T_ID, T_DESCRIPRION, d_id, TOTAL_PRICE,t_date) VALUES (3, 'Spanish Open', 3, 2000000,'03-mar-2014');
INSERT INTO TOURNAMENT2 (T_ID, T_DESCRIPRION, d_id, TOTAL_PRICE,t_date) VALUES (4, 'Chiinese Open', 4, 300000,'15-jul-2014');
INSERT INTO TOURNAMENT2 (T_ID, T_DESCRIPRION, d_id, TOTAL_PRICE,t_date) VALUES (5, 'Dubai Open', 5, 600000,'10-aug-2014');
INSERT INTO TOURNAMENT2 (T_ID, T_DESCRIPRION, d_id, TOTAL_PRICE,t_date) VALUES (6, 'US Master', 6, 1000000,'10-jul-2014');


INSERT INTO RESULTS1 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (1, 1, 1, 1, 10000);
INSERT INTO RESULTS1 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (2, 2, 2, 4, 1000);
INSERT INTO RESULTS1 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (3, 2, 3, 3, 10000);
INSERT INTO RESULTS1 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (3, 1, 3, 2, 1100);
INSERT INTO RESULTS1 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (4, 6, 4, 3, 6000);
INSERT INTO RESULTS1 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (4, 2, 4, 2, 9000);
INSERT INTO RESULTS1 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (4, 1, 4, 1, 10000);
INSERT INTO RESULTS1 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (3, 5, 3, 2, 9500);
INSERT INTO RESULTS1 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (4, 5, 4, 4, 10000);
INSERT INTO RESULTS1 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (2, 5, 2, 7, 100);

INSERT INTO RESULTS2 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (1, 1, 1, 1, 1000);
INSERT INTO RESULTS2 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (1, 2, 1, 3, 2000);
INSERT INTO RESULTS2 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (2, 2, 2, 1, 6000);
INSERT INTO RESULTS2 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (3, 2, 2, 3, 17000);
INSERT INTO RESULTS2 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (3, 1, 2, 12, 1100);
INSERT INTO RESULTS2 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (4, 6, 4, 10, 8000);
INSERT INTO RESULTS2 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (4, 2, 4, 2, 12000);
INSERT INTO RESULTS2 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (4, 1, 4, 3, 10000);
INSERT INTO RESULTS2 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (3, 5, 3, 1, 9000);
INSERT INTO RESULTS2 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (4, 5, 4, 5, 1000);
INSERT INTO RESULTS2 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (2, 5, 2, 3, 1000);
INSERT INTO RESULTS2 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (5, 5, 5, 3, 8000);
INSERT INTO RESULTS2 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (5, 2, 5, 2, 16000);
INSERT INTO RESULTS2 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (5, 1, 5, 1, 20000);
INSERT INTO RESULTS2 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (6, 1, 6, 3, 2000);
INSERT INTO RESULTS2 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (6, 5, 6, 2, 9400);
INSERT INTO RESULTS2 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (6, 4, 6, 1, 12000);

SELECT * from Team1;
SELECT * FROM TEAM2;
SELECT * FROM Players1;
SELECT * FROM Players2;
SELECT * FROM Results1;
SELECT * FROM Results2;
SELECT * FROM Tournament1;
SELECT * FROM Tournament2;

/* Dimensional tables */

CREATE TABLE Player_Dim(
  player_SK INTEGER PRIMARY KEY,
  player_name VARCHAR(50)
);

CREATE TABLE Team_Dim(
  team_SK INTEGER PRIMARY KEY,
  team_name VARCHAR(50)
);

CREATE TABLE Tournament_Dim (
  tournament_SK INTEGER PRIMARY KEY,
  tournament_desc VARCHAR(500),
  total_price INTEGER
);

CREATE TABLE Date_Dim (
  date_SK INTEGER PRIMARY KEY,
  day INTEGER,
  month INTEGER,
  year INTEGER,
  week INTEGER,
  quarter INTEGER,
  day_of_week INTEGER
);

CREATE TABLE Fact_Results_Dim (
  player_SK INTEGER,
  team_SK INTEGER,
  tournament_SK INTEGER,
  date_SK INTEGER,
  rank INTEGER,
  price INTEGER,
  CONSTRAINT FK_Player_Dim FOREIGN KEY (player_SK) REFERENCES Player_Dim,
  CONSTRAINT FK_Team_Dim FOREIGN KEY (team_SK) REFERENCES Team_Dim,
  CONSTRAINT FK_Tournament FOREIGN KEY (tournament_SK) REFERENCES Tournament_Dim,
  CONSTRAINT FK_Date_Dim FOREIGN KEY (date_SK) REFERENCES Date_Dim,
  CONSTRAINT FK_Primary PRIMARY KEY (player_SK, team_SK, tournament_SK, date_SK)
);


/* INITIAL ETL */
/* Load Dimension Teams */
/* Staging Area*/

CREATE TABLE Team_Stage(
  t_sk INTEGER,
  sourceDB INTEGER,
  t_id INTEGER,
  t_name VARCHAR(50)
);

create sequence Team_Stage_seq
start with 1
increment by 1
nomaxvalue;

drop trigger Team_Stage_trigger;

create trigger Team_Stage_trigger
before insert on Team_Stage
for each row
begin
select Team_Stage_seq.nextval into :new.t_sk from dual;
end;

insert into Team_Stage (sourcedb,t_id,t_name)
select 1,team_id,team_name from Team1;

insert into Team_Stage (sourcedb,t_id,t_name)
select 2,team_id,team_name from Team2;

select * from Team_Stage;

/* Load dimension Team */
INSERT INTO Team_Dim SELECT t_SK, t_name from Team_Stage;

-- test Team_Dim
select * from Team_Dim;


/* Dimension Player */
CREATE TABLE Player_Stage(
  p_sk INTEGER,
  sourceDB INTEGER,
  p_id INTEGER,
  p_name VARCHAR(50),
  p_sname VARCHAR(50),
  t_id INTEGER
);

create sequence Player_Stage_seq
start with 1
increment by 1
nomaxvalue;

drop trigger Player_Stage_trigger;

create trigger Player_Stage_trigger
before insert on Player_Stage
for each row
begin
select Player_Stage_seq.nextval into :new.p_sk from dual;
end;

insert into Player_Stage (sourcedb,p_id,p_name, p_sname, t_id)
select 1, p_id, p_name, p_sname, team_id from Players1;

insert into Player_Stage (sourcedb,p_id,p_name, p_sname, t_id)
select 2, p_id, p_name, p_sname, team_id from Players2;

select * from Player_Stage;

/* Load dimension Player */
INSERT INTO Player_Dim SELECT p_SK, p_name from Player_Stage;

-- test Player_Dim
select * from Player_Dim;


/* Dimension Tournament*/

CREATE TABLE Tournament_Stage(
  tour_sk INTEGER,
  sourceDB INTEGER,
  tour_id INTEGER,
  tour_desc VARCHAR(100),
  tour_d_id INTEGER,
  tour_date DATE,
  total_price FLOAT
);

create sequence Tournament_Stage_seq
start with 1
increment by 1
nomaxvalue;


drop trigger Tournament_Stage_trigger;

create trigger Tournament_Stage_trigger
before insert on Tournament_Stage
for each row
begin
select Tournament_Stage_seq.nextval into :new.tour_sk from dual;
end;


insert into Tournament_Stage (sourcedb,tour_id,tour_desc, tour_d_id ,tour_date, total_price)
select 1, T_id, t_descriprion, d_id, t_date, Total_price from Tournament1;

insert into Tournament_Stage (sourcedb,tour_id,tour_desc, tour_d_id, tour_date, total_price)
select 2, T_id, t_descriprion, d_id, t_date, (Total_price*1.3) from Tournament2;

select * from Tournament_Stage;

/* Load dimension Player */
INSERT INTO Tournament_Dim SELECT tour_sk, tour_desc, total_price from Tournament_Stage;

-- test Player_Dim
select * from Tournament_Dim;


/* Dimension Date*/
CREATE TABLE Date_Stage(
  date_sk INTEGER,
  sourceDB INTEGER,
  date_id INTEGER,
  day INTEGER,
  month INTEGER,
  year INTEGER,
  week INTEGER,
  quarter INTEGER,
  day_of_week INTEGER
);

create sequence Date_Stage_seq
start with 1
increment by 1
nomaxvalue;

drop trigger Date_Stage_trigger;

create trigger Date_Stage_trigger
before insert on Date_Stage
for each row
begin
select Date_Stage_seq.nextval into :new.date_sk from dual;
end;

 insert into Date_Stage (sourcedb, date_id, day, month, year, week, quarter, day_of_week)
 select 1, d_id,
  -- day
     cast(to_char(t_date,'DD') as integer),
  -- month
     cast(to_char(t_date,'MM') as integer),
  -- year
     cast(to_char(t_date,'YYYY') as integer),
  -- week
     cast(to_char(to_date(t_date,'DD/MM/YYYY'),'WW') as integer),
  -- quarter
     cast(to_char(to_date(t_date, 'DD/MM/YYYY'), 'Q') as INTEGER),
  -- week day
     cast(to_char(to_date(t_date,'DD/MM/YYYY'), 'D') as INTEGER) from Tournament1;


 insert into Date_Stage (sourcedb, date_id, day, month, year, week, quarter, day_of_week)
 select 2, d_id,
  -- day
     cast(to_char(t_date,'DD') as integer),
  -- month
     cast(to_char(t_date,'MM') as integer),
  -- year
     cast(to_char(t_date,'YYYY') as integer),
  -- week
     cast(to_char(to_date(t_date,'DD/MM/YYYY'),'WW') as integer),
  -- quarter
     cast(to_char(to_date(t_date, 'DD/MM/YYYY'), 'Q') as INTEGER),
  -- week day
     cast(to_char(to_date(t_date,'DD/MM/YYYY'), 'D') as INTEGER) from Tournament2;

select * from Date_Stage;

/* Load dimension Date */
INSERT INTO Date_Dim SELECT date_sk, day, month, year, week, quarter, day_of_week from Date_Stage;

-- test Date_Dim
select * from Date_Dim;

/* Load Fact table */
create table Fact_Stage(
  team_sk INTEGER,
  player_sk INTEGER,
  Tour_sk INTEGER,
  date_sk INTEGER,
  team_id INTEGER,
  player_id INTEGER,
  Tour_id INTEGER,
  date_id INTEGER,
  rank INTEGER,
  price FLOAT,
  sourceDB INTEGER
);

insert into Fact_Stage(team_id, player_id, Tour_id, date_id,rank, price, sourcedb) select team_id, p_id, T_id, d_id,
rank, price, 1 from Results1 JOIN Players1 USING (p_id);

insert into Fact_Stage(team_id, player_id, Tour_id, date_id, rank, price, sourcedb) select team_id, p_id, T_id, d_id,
rank, price, 2 from Results2 JOIN Players2 USING (p_id);

/* Assign Surrogate Keys */
/* Team SK */
update Fact_Stage
set team_sk=
  (select Team_Stage.t_sk from
  Team_Stage  where (Team_Stage.sourceDB=Fact_Stage.sourceDB and
  Team_Stage.t_id = Fact_Stage.team_id));

update Fact_Stage
set player_sk=
  (select Player_Stage.p_sk from
  Player_Stage  where (Player_Stage.sourceDB=Fact_Stage.sourceDB and
  Player_Stage.p_id = Fact_Stage.player_id));

update Fact_Stage
set Tour_sk=
  (select Tournament_Stage.tour_sk from
  Tournament_Stage  where (Tournament_Stage.sourceDB=Fact_Stage.sourceDB and
  Tournament_Stage.tour_id = Fact_Stage.Tour_id));

update Fact_Stage
set date_sk=
  (select Date_Stage.date_sk from
  Date_Stage  where (Date_Stage.sourceDB=Fact_Stage.sourceDB and
  Date_Stage.date_id = Fact_Stage.date_id));

select * from Fact_Results_Dim;

-- insertion to fact_dim table
insert into Fact_Results_Dim select player_sk, team_sk, Tour_sk, date_sk, rank, price from Fact_Stage;

/* END INITIAL ETL LOAD */
/* Second ETL LOAD */
/* new data in database 1 */
INSERT INTO PLAYERS1 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (7, 'Alan', 'Parker', 1);
INSERT INTO PLAYERS1 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (8, 'Martha', 'Bag', 2);

INSERT INTO TOURNAMENT1 (T_ID, T_DESCRIPRION, d_id, TOTAL_PRICE, t_date) VALUES (5, 'Saudi Open', 5, 500000, '28-nov-2014');

INSERT INTO RESULTS1 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (5, 1, 5, 1, 60000);
INSERT INTO RESULTS1 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (5, 7, 5, 5, 20000);
INSERT INTO RESULTS1 (T_ID, P_ID, d_id, RANK, PRICE) VALUES (2, 8, 2, 3, 1000);

/* SECOND ETL */
/* Dimension Player */

insert into Player_Stage (sourcedb,p_id,p_name, p_sname, t_id)
select 1,p_id, p_name, p_sname, team_id from Players1 p1 where
NOT EXISTS (SELECT * FROM Player_Stage ps
              WHERE  ps.p_id= p1.p_id and ps.sourcedb=1 );

insert into Player_Dim select p_sk, p_name from Player_Stage ps where
NOT EXISTS (SELECT * FROM Player_Dim
              WHERE  ps.p_sk= Player_Dim.player_SK );  /* updating only new entities */

/*Dimension Tournament*/

insert into Tournament_Stage (sourcedb,tour_id,tour_desc, tour_d_id ,tour_date, total_price)
select 1, T_id, t_descriprion, d_id, t_date, Total_price from Tournament1 t1 where
NOT EXISTS (SELECT * FROM Tournament_Stage ts
              WHERE  ts.tour_id= t1.T_id and ts.sourcedb=1 );

INSERT INTO Tournament_Dim SELECT tour_sk, tour_desc, total_price from Tournament_Stage ts where
NOT EXISTS (SELECT * FROM Tournament_Dim
              WHERE  ts.tour_sk= Tournament_Dim.tournament_SK );  /* updating only new entities */

/*Dimension Date*/

insert into Date_Stage (sourcedb, date_id, day, month, year, week, quarter, day_of_week)
 select 1, d_id,
  -- day
     cast(to_char(t_date,'DD') as integer),
  -- month
     cast(to_char(t_date,'MM') as integer),
  -- year
     cast(to_char(t_date,'YYYY') as integer),
  -- week
     cast(to_char(to_date(t_date,'DD/MM/YYYY'),'WW') as integer),
  -- quarter
     cast(to_char(to_date(t_date, 'DD/MM/YYYY'), 'Q') as INTEGER),
  -- week day
     cast(to_char(to_date(t_date,'DD/MM/YYYY'), 'D') as INTEGER) from Tournament1 t1 where
NOT EXISTS(SELECT * from Date_Stage ds WHERE ds.date_id = t1.d_id and ds.sourceDB=1);

/* Load dimension Date */
INSERT INTO Date_Dim SELECT date_sk, day, month, year, week, quarter, day_of_week from Date_Stage ds WHERE
NOT EXISTS(SELECT * FROM Date_Dim WHERE ds.date_sk = Date_Dim.date_SK) ; /* updating only new entities */

/* Second Load Fact Table */
insert into Fact_Stage(team_id, player_id, Tour_id, date_id,rank, price, sourcedb) select team_id, p_id, T_id, d_id,
rank, price, 1 from Results1 r1 JOIN Players1 p1 USING (p_id) WHERE
NOT EXISTS(SELECT * FROM Fact_Stage fs
           WHERE fs.team_id=p1.team_id and fs.player_id= p_id and
                 fs.Tour_id=r1.T_ID and fs.date_id = r1.d_id and fs.sourceDB = 1);

select * from fact_stage;

/* Assign Surrogate Keys */

update Fact_Stage
set team_sk=
  (select Team_Stage.t_sk from
  Team_Stage  where (Team_Stage.sourceDB=Fact_Stage.sourceDB and
  Team_Stage.t_id = Fact_Stage.team_id));

update Fact_Stage
set player_sk=
  (select Player_Stage.p_sk from
  Player_Stage  where (Player_Stage.sourceDB=Fact_Stage.sourceDB and
  Player_Stage.p_id = Fact_Stage.player_id));

update Fact_Stage
set Tour_sk=
  (select Tournament_Stage.tour_sk from
  Tournament_Stage  where (Tournament_Stage.sourceDB=Fact_Stage.sourceDB and
  Tournament_Stage.tour_id = Fact_Stage.Tour_id));

update Fact_Stage
set date_sk=
  (select Date_Stage.date_sk from
  Date_Stage  where (Date_Stage.sourceDB=Fact_Stage.sourceDB and
  Date_Stage.date_id = Fact_Stage.date_id));


insert into Fact_Results_Dim select player_sk, team_sk, Tour_sk, date_sk, rank, price from Fact_Stage where
NOT EXISTS (SELECT * FROM Fact_Results_Dim frd
              WHERE  Fact_Stage.player_sk= frd.player_SK
                     and Fact_Stage.team_sk= frd.team_SK
                     and Fact_Stage.Tour_sk= frd.tournament_SK
                     and Fact_Stage.date_sk = frd.date_SK);  /* updating only new entities */
select * from Fact_Results_Dim;

/* UPDATE FACT TABLE */
/* End of Second Load */
