drop table TEAMS;
drop table MATCHES;
drop table EUROLEAGUE;
drop table LOGTEAM;
drop sequence match_id_seq;
drop TRIGGER log_trigger;
drop TRIGGER match_trigger;
drop TRIGGER check_trigger;

CREATE TABLE TEAMS(
  team_name VARCHAR(50) not null PRIMARY KEY,
  team_country VARCHAR(50),
  CONSTRAINT ch_country CHECK (team_country IN ('England', 'Spain'))
);

CREATE TABLE MATCHES(
  match_id int NOT NULL PRIMARY KEY,
  teamA_name VARCHAR(50),
  teamB_name VARCHAR(50),
  goalA NUMBER CHECK (goalA>0),
  goalB NUMBER CHECK (goalB>0),
  competition VARCHAR(50),
  FOREIGN KEY (teamA_name) REFERENCES TEAMS(team_name),
  FOREIGN KEY (teamB_name) REFERENCES TEAMS(team_name),
  CONSTRAINT ch_competition CHECK (competition IN ('Champions league', 'Europa league',
                                               'Premier league', 'La league'))
);

CREATE TABLE EUROLEAGUE(
  team_name VARCHAR(50) PRIMARY KEY NOT NULL ,
  points int,
  goals_scored INT,
  goals_conceded int,
  difference int
);

CREATE TABLE LOGTEAM(
 time_stamp date
);

-- a) creating sequence for match_id
CREATE SEQUENCE match_id_seq
      START WITH 1
      INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trigger_match_id
  BEFORE INSERT ON MATCHES
  FOR EACH ROW
  Begin
      SELECT match_id_seq.nextval into :new.match_id from dual;
  END;

-- triggers
-- a), b) add time stamp to LOGTEAM when insertion to TEAMS table, also add to EUROLEAGUE table
CREATE or REPLACE TRIGGER log_trigger
  BEFORE INSERT on TEAMS
  FOR EACH ROW
  DECLARE team_count NUMBER;
  BEGIN
    INSERT INTO LOGTEAM values(sysdate);
    SELECT count(*) INTO team_count FROM TEAMS WHERE team_name=:new.team_name;
    if(team_count=0)
      THEN
         INSERT INTO EUROLEAGUE VALUES (:new.team_name, 0, 0, 0, 0);
      ELSE
         raise_application_error(-20015, 'team name is already exists in EUROLEAGUE table');
    END IF;
  END;--   FOREIGN KEY (team_name

-- c) matches table checking trigger
CREATE OR REPLACE TRIGGER match_trigger
  BEFORE INSERT ON MATCHES
  FOR EACH ROW
  DECLARE
    teamA_country VARCHAR(50);
    teamB_country VARCHAR(50);
  BEGIN
    SELECT team_country INTO teamA_country FROM TEAMS WHERE TEAMS.team_name=:new.teamA_name;
    SELECT team_country INTO teamB_country FROM TEAMS WHERE TEAMS.team_name=:new.teamB_name;
    IF (teamA_country not LIKE 'England' OR teamB_country not LIKE 'England' OR :new.competition not LIKE 'Premier league')
      AND
       (teamA_country not LIKE 'Spain' OR teamB_country not LIKE 'Spain' OR :new.competition not LIKE 'La league')
      THEN
      raise_application_error(-20020, 'teams doesnt match with  competition names');
   END IF;
  END;

-- d) matches checker trigger
CREATE OR REPLACE TRIGGER check_trigger
  BEFORE INSERT ON MATCHES
  FOR EACH ROW
  DECLARE
    match_countA NUMBER;
    match_countB NUMBER;
--     winning_team VARCHAR(50);
  BEGIN
    SELECT count(*) INTO match_countA FROM MATCHES WHERE teamA_name=:new.teamA_name;
    SELECT count(*) INTO match_countB FROM MATCHES WHERE teamB_name=:new.teamB_name;
    IF (match_countA >4 OR match_countB >4)
      THEN
      raise_application_error(-20050, 'team already has more than 4 matches');
    END IF;

-- check if teamA is winner
    IF (:new.goalA>:new.goalB)
      THEN
--         update winner details
      UPDATE EUROLEAGUE SET points = points+3, goals_scored = goals_scored+:new.goalA,
                            goals_conceded = goals_conceded + 1,
                            difference = difference + (:new.goalA-:new.goalB)
      WHERE EUROLEAGUE.team_name=:new.teamA_name;

--       update looser details
      UPDATE EUROLEAGUE SET points = points+0, goals_scored = goals_scored+:new.goalB,
                            goals_conceded = goals_conceded +1,
                            difference = difference + 0
      WHERE EUROLEAGUE.team_name=:new.teamB_name;
    ELSE
-- check ifteamB is winner
      IF (:new.goalB>:new.goalA)
        THEN
  --         update winners details
        UPDATE EUROLEAGUE SET points = points+3, goals_scored = goals_scored+:new.goalB,
                              goals_conceded = goals_conceded+1,
                              difference = difference + (:new.goalB-:new.goalA)
        WHERE EUROLEAGUE.team_name=:new.teamB_name;

 --       update looser details
      UPDATE EUROLEAGUE SET points = points+0, goals_scored = goals_scored+:new.goalA,
                            goals_conceded = goals_conceded +1,
                            difference = difference + 0
      WHERE EUROLEAGUE.team_name=:new.teamA_name;
      ELSE

-- if match is a draw
      IF (:new.goalB=:new.goalA)
        THEN

        UPDATE EUROLEAGUE SET points = points+1, goals_scored = goals_scored+:new.goalB,
                              goals_conceded = goals_conceded + 1,
                              difference = difference + 0
        WHERE EUROLEAGUE.team_name=:new.teamB_name;

        UPDATE EUROLEAGUE SET points=points+1, goals_scored = goals_scored+:new.goalA,
                              goals_conceded = goals_conceded + 1,
                              difference = difference + 0
          WHERE EUROLEAGUE.team_name=:new.teamA_name;
      END IF;
     END IF;
    END IF;
  END;

-- insertion values to TEAMS table
INSERT INTO TEAMS VALUES ('Arsenal', 'England');
INSERT INTO TEAMS VALUES ('Manchester United', 'England');
INSERT INTO TEAMS VALUES ('Chelsea', 'England');
INSERT INTO TEAMS VALUES ('Everton', 'England');
INSERT INTO TEAMS VALUES ('Barcelona', 'Spain');
INSERT INTO TEAMS VALUES ('Real Madrid', 'Spain');
INSERT INTO TEAMS VALUES ('Atletico Madrid', 'Spain');
INSERT INTO TEAMS VALUES ('Sevilla', 'Spain');

-- insertion values to MATCHES table
INSERT INTO MATCHES VALUES (1, 'Everton', 'Arsenal', 3, 2, 'Premier league');
INSERT INTO MATCHES VALUES (1, 'Arsenal', 'Chelsea', 5, 3, 'Premier league');
INSERT INTO MATCHES VALUES (1, 'Everton', 'Manchester United', 4, 2, 'Premier league');
INSERT INTO MATCHES VALUES (1, 'Everton', 'Arsenal', 4, 3, 'Premier league');


-- checking log_trigger
SELECT * FROM EUROLEAGUE;
SELECT * FROM TEAMS;
SELECT * FROM LOGTEAM;
SELECT * FROM MATCHES;

