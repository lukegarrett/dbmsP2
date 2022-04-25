-- Michael Dobson and Luke Garrett --
-- Vanderbilt University --
-- CS 3265: Database Management Systems --
-- US Accidents Script File --
-- FUll LOAD DATA SCRIPT AND DB --

-- Create database --
DROP DATABASE IF EXISTS us_accidents;
CREATE DATABASE us_accidents;
USE us_accidents;

-- Create megatable --
DROP TABLE IF EXISTS accidents_megatable;
CREATE TABLE accidents_megatable (
	accident_id VARCHAR(20) NOT NULL,
    severity TINYINT,
    start_time DATETIME,
    end_time DATETIME,
    start_lat DECIMAL,
    start_lng DECIMAL,
    end_lat DECIMAL,
    end_lng DECIMAL,
    distance INT,
    description VARCHAR(100),
    street_number INT,
    street VARCHAR(20),
    side VARCHAR(1),
    city VARCHAR(15),
    county VARCHAR(15),
    state VARCHAR(2),
    zipcode VARCHAR(5),
    country VARCHAR(2),
    timezone VARCHAR(15),
    airport_code VARCHAR(4),
    weather_timestamp VARCHAR(20),
    temperature INT,
    wind_chill INT,
    humidity DECIMAL,
    pressure DECIMAL,
    visibility DECIMAL,
    wind_direction VARCHAR(4),
    wind_speed INT,
    precipitation DECIMAL,
    weather_condition VARCHAR(30),
    amenity VARCHAR(5),
    bump VARCHAR(5),
    crossing VARCHAR(5),
    give_way VARCHAR(5),
    junction VARCHAR(5),
    no_exit VARCHAR(5),
    railway VARCHAR(5),
    roundabout VARCHAR(5),
    station VARCHAR(5),
    stop VARCHAR(5),
    traffic_calming VARCHAR(5),
    traffic_signal VARCHAR(5),
    turning_loop VARCHAR(5),
    sunrise_sunset VARCHAR(5),
    civil_twilight VARCHAR(5),
    nautical_twilight VARCHAR(5),
    astronomical_twilight VARCHAR(5),
    PRIMARY KEY (accident_id)    
) ENGINE = INNODB;

SELECT COUNT(*)
FROM accidents_megatable;
-- 2,845,343 accidents in this dataset 

LOAD DATA
	LOCAL INFILE 'C:/Users/micha/Downloads/US_Accidents_Dec21_updated.csv' --
    -- LOCAL INFILE 'C:/Users/garre/Desktop/US_Accidents_Dec21_updated.csv' 
	INTO TABLE accidents_megatable 
	FIELDS TERMINATED BY ',' 
	ENCLOSED BY '"'
	LINES TERMINATED BY '\n';
    
DELETE FROM accidents_megatable
WHERE accident_id = 'ID';
    
-- Megatable Decomposition --
DROP TABLE IF EXISTS accident_information;
CREATE TABLE accident_information(
	accident_id VARCHAR(20) NOT NULL,
	start_time DATETIME,
    end_time DATETIME,
    severity TINYINT,
	distance INT,
	description VARCHAR(100),
	timezone VARCHAR(15),
	PRIMARY KEY (accident_id)
);

DROP TABLE IF EXISTS geo_location;
CREATE TABLE geo_location(
	accident_id VARCHAR(20) NOT NULL,
    start_lat DECIMAL,
    start_lng DECIMAL,
    end_lat DECIMAL,
    end_lng DECIMAL,
	PRIMARY KEY (accident_id),
    CONSTRAINT fk_id FOREIGN KEY (accident_id)
		REFERENCES accident_information(accident_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

DROP TABLE IF EXISTS weather_conditions;
CREATE TABLE weather_conditions (
	accident_id VARCHAR(20) NOT NULL,
    temperature INT,
    wind_chill INT,
    humidity DECIMAL,
    pressure DECIMAL,
    visibility DECIMAL,
    wind_direction VARCHAR(4),
    wind_speed INT,
    precipitation DECIMAL,
    weather_condition VARCHAR(30),
    weather_timestamp VARCHAR(20),
    PRIMARY KEY (accident_id),
    CONSTRAINT fk_id FOREIGN KEY (accident_id)
		REFERENCES accident_information(accident_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

DROP TABLE IF EXISTS address_information;
CREATE TABLE address_information(
	accident_id VARCHAR(20) NOT NULL,
    street_number INT,
	street VARCHAR(20),
	side VARCHAR(1),
	city VARCHAR(15),
	county VARCHAR(15),
	state VARCHAR(2),
	zipcode VARCHAR(5),
	country VARCHAR(2),
	PRIMARY KEY (accident_id),
    CONSTRAINT fk_id FOREIGN KEY (accident_id)
		REFERENCES accident_information(accident_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

DROP TABLE IF EXISTS intersection_information;
CREATE TABLE intersection_information(
	accident_id VARCHAR(20) NOT NULL,
    street_number INT,
	amenity VARCHAR(5),
	bump VARCHAR(5),
	crossing VARCHAR(5),
	give_way VARCHAR(5),
	junction VARCHAR(5),
	no_exit VARCHAR(5),
	railway VARCHAR(5),
	roundabout VARCHAR(5),
	station VARCHAR(5),
	stop VARCHAR(5),
	traffic_calming VARCHAR(5),
	traffic_signal VARCHAR(5),
	turning_loop VARCHAR(5),
	PRIMARY KEY (accident_id),
    CONSTRAINT fk_id FOREIGN KEY (accident_id)
		REFERENCES accident_information(accident_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

DROP TABLE IF EXISTS twilight_information;
CREATE TABLE twilight_information(
	accident_id VARCHAR(20) NOT NULL,
	sunrise_sunset VARCHAR(5),
	civil_twilight VARCHAR(5),
	nautical_twilight VARCHAR(5),
	astronomical_twilight VARCHAR(5),
	PRIMARY KEY (accident_id),
    CONSTRAINT fk_id FOREIGN KEY (accident_id)
		REFERENCES accident_information(accident_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
DROP TABLE IF EXISTS weather_severity;
CREATE TABLE weather_severity(
	weather_condition VARCHAR(40),
    average_severity DOUBLE
);


-- DATA INSERT --
SET SQL_SAFE_UPDATES = 0;

DELETE FROM accident_information;
INSERT INTO accident_information
SELECT 
	accident_id,
	start_time,
    end_time,
    severity ,
	distance ,
	description,
	timezone
FROM accidents_megatable;

DELETE FROM weather_conditions;
INSERT INTO weather_conditions
SELECT 
	accident_id,
    temperature,
    wind_chill,
    humidity,
    pressure,
    visibility,
    wind_direction,
    wind_speed,
    precipitation,
    weather_condition,
    weather_timestamp
FROM accidents_megatable;

DELETE FROM weather_severity;
INSERT INTO weather_severity
SELECT weather_condition, AVG(severity) as average_severity
FROM accident_information
		JOIN weather_conditions USING(accident_id)
GROUP BY weather_condition;

DELETE FROM geo_location;
INSERT INTO geo_location
SELECT 
	accident_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng
FROM accidents_megatable;

DELETE FROM address_information;
INSERT INTO address_information
SELECT 
	accident_id,
    street_number,
	street,
	side,
	city,
	county,
	state,
	zipcode,
	country
FROM accidents_megatable;

DELETE FROM intersection_information;
INSERT INTO intersection_information
SELECT 
	accident_id,
    street_number,
	amenity,
	bump,
	crossing,
	give_way,
	junction,
	no_exit,
	railway,
	roundabout,
	station,
	stop,
	traffic_calming,
	traffic_signal,
	turning_loop
FROM accidents_megatable;

DELETE FROM twilight_information;
INSERT INTO twilight_information
SELECT 
	accident_id,
	sunrise_sunset,
	civil_twilight ,
	nautical_twilight,
	astronomical_twilight
FROM accidents_megatable;

-- CREATE INDEX --
USE us_accidents;

-- DROP INDEX IF EXISTS index_accident_id ON accidents_megatable;
CREATE INDEX index_accident_id ON accidents_megatable(accident_id);
USE us_accidents;
CREATE INDEX index_accident_id_information ON accident_information(accident_id);
USE us_accidents;
CREATE INDEX index_accident_id_address ON address_information(accident_id);
USE us_accidents;
CREATE INDEX index_accident_id_geo ON geo_location(accident_id);
USE us_accidents;
CREATE INDEX index_accident_id_intersection ON intersection_information(accident_id);
USE us_accidents;
CREATE INDEX index_accident_id_twilight ON twilight_information(accident_id);
USE us_accidents;
CREATE INDEX index_accident_id_weather ON weather_conditions(accident_id);
-- VIEWS --
-- Create a view for each table --
-- accident_information --
CREATE OR REPLACE VIEW accident_info_view AS
SELECT *
FROM accident_information;

-- address_information --
CREATE OR REPLACE VIEW address_info_view AS
SELECT *
FROM address_information;

-- geo_location --
CREATE OR REPLACE VIEW geo_location_view AS
SELECT *
FROM geo_location;

-- intersection_information --
CREATE OR REPLACE VIEW intersection_info_view AS
SELECT *
FROM intersection_information;

-- twilight_information --
CREATE OR REPLACE VIEW twilight_info_view AS
SELECT *
FROM twilight_information;

-- weather_conditions --
CREATE OR REPLACE VIEW weather_conditions_view AS
SELECT *
FROM weather_conditions;
-- average severity by state view --
CREATE OR REPLACE VIEW average_severity_view AS
SELECT state, AVG(severity) as average_severity
FROM accident_information
		JOIN address_information USING(accident_id)
GROUP BY state;
-- weather condition avg severity --
CREATE OR REPLACE VIEW average_severity_weather_view AS
SELECT weather_condition, AVG(severity) as average_severity
FROM accident_information
		JOIN weather_conditions USING(accident_id)
GROUP BY weather_condition;

-- STORED PROCEDURES --
-- Get a specifc accident info --
DROP PROCEDURE IF EXISTS getAccidentInfo;
DELIMITER //
CREATE PROCEDURE getAccidentInfo(IN id VARCHAR(20))
BEGIN
	SELECT *
    FROM accident_info_view
    WHERE accident_id = id;
END//
DELIMITER ;

-- get average severity of states that have an average severity above a certain value --
DROP PROCEDURE IF EXISTS getStateSeverity;
DELIMITER //
CREATE PROCEDURE getStateSeverity(IN minimum INT)
BEGIN
	SELECT *
    FROM average_severity_view
    HAVING average_severity >= minimum
    ORDER BY average_severity DESC;
END//
DELIMITER ;

-- get average severity during specific weather conditions --
DROP PROCEDURE IF EXISTS getWeatherSeverity;
DELIMITER //
CREATE PROCEDURE getWeatherSeverity(IN minimum INT)
BEGIN
	SELECT *
    FROM weather_severity
    HAVING average_severity >= minimum
    ORDER BY average_severity DESC;
END//
DELIMITER ;

SELECT severity, COUNT(*)
FROM accident_information
GROUP BY severity;

-- Full join --
DROP PROCEDURE IF EXISTS getAllInfo;
DELIMITER //
CREATE PROCEDURE getAllInfo(IN id VARCHAR(20))
BEGIN
	SELECT *
    FROM accident_information
		JOIN address_information USING (accident_id)
        JOIN geo_location USING (accident_id)
        JOIN intersection_information USING (accident_id)
        JOIN twilight_information USING (accident_id)
        JOIN weather_conditions USING (accident_id)
	WHERE accident_id = id;
END//
DELIMITER ;

-- Severity Triggers --
USE us_accidents;

DELIMITER // 

CREATE TRIGGER accident_information_before_insert_severity_min
BEFORE INSERT
ON accident_information
FOR EACH ROW
BEGIN
	IF NEW.severity < 0 THEN
		SET NEW.severity = 0;
	END IF;
END //
DELIMITER ;

DELIMITER // 

CREATE TRIGGER accident_information_before_insert_severity_max
BEFORE INSERT
ON accident_information
FOR EACH ROW
BEGIN
	IF NEW.severity > 4 THEN
		SET NEW.severity = 4;
	END IF;
END //
DELIMITER ;

-- ddl_sql file --
USE us_accidents;
SELECT *
FROM accident_information;

DROP PROCEDURE IF EXISTS deleteAccident;
DELIMITER //
CREATE PROCEDURE deleteAccident(IN id VARCHAR(20))
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET sql_error = TRUE;

	START TRANSACTION;
		DELETE FROM accident_information
        WHERE accident_id = id;
        DELETE FROM address_information
        WHERE accident_id = id;
        DELETE FROM geo_location
        WHERE accident_id = id;
        DELETE FROM intersection_information
        WHERE accident_id = id;
        DELETE FROM weather_conditions
        WHERE accident_id = id;
        

		IF sql_error = FALSE THEN
			COMMIT;
			SELECT 'The accident was deleted.';
		ELSE
			ROLLBACK;
			SELECT 'The transaction was rolled back.';
		END IF;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS insertAccident;
DELIMITER //
CREATE PROCEDURE insertAccident(
	IN accident_id VARCHAR(20),
    IN severity TINYINT,
    IN start_time DATETIME,
    IN end_time DATETIME,
    IN start_lat DECIMAL,
    IN start_lng DECIMAL,
    IN end_lat DECIMAL,
    IN end_lng DECIMAL,
    IN distance INT,
    IN description VARCHAR(100),
    IN street_number INT,
    IN street VARCHAR(20),
    IN side VARCHAR(1),
    IN city VARCHAR(15),
    IN county VARCHAR(15),
    IN state VARCHAR(2),
    IN zipcode VARCHAR(5),
    IN country VARCHAR(2),
    IN timezone VARCHAR(15),
    IN airport_code VARCHAR(4),
    IN weather_timestamp VARCHAR(20),
    IN temperature INT,
    IN wind_chill INT,
    IN humidity DECIMAL,
    IN pressure DECIMAL,
    IN visibility DECIMAL,
    IN wind_direction VARCHAR(4),
    IN wind_speed INT,
    IN precipitation DECIMAL,
    IN weather_condition VARCHAR(30),
    IN amenity VARCHAR(5),
    IN bump VARCHAR(5),
    IN crossing VARCHAR(5),
    IN give_way VARCHAR(5),
    IN junction VARCHAR(5),
    IN no_exit VARCHAR(5),
    IN railway VARCHAR(5),
    IN roundabout VARCHAR(5),
    IN station VARCHAR(5),
    IN stop VARCHAR(5),
    IN traffic_calming VARCHAR(5),
    IN traffic_signal VARCHAR(5),
    IN turning_loop VARCHAR(5),
    IN sunrise_sunset VARCHAR(5),
    IN civil_twilight VARCHAR(5),
    IN nautical_twilight VARCHAR(5),
    IN astronomical_twilight VARCHAR(5))
BEGIN
	-- DECLARE sql_error INT DEFAULT FALSE;
    -- DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET sql_error = TRUE;

	START TRANSACTION;
		INSERT INTO weather_conditions
		VALUES (
			accident_id,
			temperature,
			wind_chill,
			humidity,
			pressure,
			visibility,
			wind_direction,
			wind_speed,
			precipitation,
			weather_condition,
			weather_timestamp);
            
		INSERT INTO geo_location
		VALUES (
			accident_id,
			start_lat,
			start_lng,
			end_lat,
			end_lng);

		INSERT INTO address_information
		VALUES (
			accident_id,
			street_number,
			street,
			side,
			city,
			county,
			state,
			zipcode,
			country);

		INSERT INTO intersection_information
		VALUES (
			accident_id,
			street_number,
			amenity,
			bump,
			crossing,
			give_way,
			junction,
			no_exit,
			railway,
			roundabout,
			station,
			stop,
			traffic_calming,
			traffic_signal,
			turning_loop);

		INSERT INTO accident_information
		VALUES (
			accident_id,
			start_time,
			end_time,
			severity ,
			distance ,
			description,
			timezone);

		INSERT INTO twilight_information
		VALUES (
			accident_id,
			sunrise_sunset,
			civil_twilight ,
			nautical_twilight,
			astronomical_twilight);
    
		IF sql_error = FALSE THEN
			COMMIT;
			SELECT 'The accident was inserted.';
		ELSE
			ROLLBACK;
			SELECT 'The transaction was rolled back.';
		END IF;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS insertAccidentInfo;
DELIMITER //
CREATE PROCEDURE insertAccidentInfo(
	accident_id VARCHAR(20),
	start_time DATETIME,
    end_time DATETIME,
    severity TINYINT,
	distance INT,
	description VARCHAR(100),
	timezone VARCHAR(15))
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET sql_error = TRUE;

	START TRANSACTION;
		INSERT INTO accident_information
		VALUES (
			accident_id,
			start_time,
			end_time,
			severity ,
			distance ,
			description,
			timezone);
    
		IF sql_error = FALSE THEN
			COMMIT;
			SELECT 'The accident was inserted.';
		ELSE
			ROLLBACK;
			SELECT 'The transaction was rolled back.';
		END IF;
END//
DELIMITER ;

SELECT *
FROM accident_information
WHERE accident_id = 'X6';

DROP PROCEDURE IF EXISTS updateAccidentInfo;
DELIMITER //
CREATE PROCEDURE updateAccidentInfo(
	id VARCHAR(20),
    sev TINYINT)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET sql_error = TRUE;

	START TRANSACTION;
		UPDATE accident_information
        SET severity = sev
        WHERE accident_id = id;
    
		IF sql_error = FALSE THEN
			COMMIT;
			SELECT 'The accident was inserted.';
		ELSE
			ROLLBACK;
			SELECT 'The transaction was rolled back.';
		END IF;
END//
DELIMITER ;