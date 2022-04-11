-- Michael Dobson and Luke Garrett --
-- Vanderbilt University --
-- CS 3265: Database Management Systems --
-- US Accidents Script File --
-- LOAD DATA SCRIPT --

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
    weather_condition VARCHAR(10),
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
	LOCAL INFILE 'C:/Users/micha/Downloads/US_Accidents_Dec21_updated.csv' 
	INTO TABLE accidents_megatable 
	FIELDS TERMINATED BY ',' 
	ENCLOSED BY '"'
	LINES TERMINATED BY '\n';
    
DELETE FROM accidents_megatable
WHERE accident_id = 'ID';
    
-- Megatable Decomposition --
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
    weather_condition VARCHAR(10),
    weather_timestamp VARCHAR(20),
    PRIMARY KEY (accident_id),
    CONSTRAINT fk_id FOREIGN KEY (accident_id)
		REFERENCES accidents_megatable(accident_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE = INNODB;

DROP TABLE IF EXISTS geo_location;
CREATE TABLE geo_location(
	accident_id VARCHAR(20) NOT NULL,
    start_lat DECIMAL,
    start_lng DECIMAL,
    end_lat DECIMAL,
    end_lng DECIMAL,
	PRIMARY KEY (accident_id),
    CONSTRAINT fk_id FOREIGN KEY (accident_id)
		REFERENCES accidents_megatable(accident_id)
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
		REFERENCES accidents_megatable(accident_id)
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
		REFERENCES accidents_megatable(accident_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

DROP TABLE IF EXISTS accident_information;
CREATE TABLE accident_information(
	accident_id VARCHAR(20) NOT NULL,
	start_time DATETIME,
    end_time DATETIME,
    severity TINYINT,
	distance INT,
	description VARCHAR(100),
	timezone VARCHAR(15),
	PRIMARY KEY (accident_id),
    CONSTRAINT fk_id FOREIGN KEY (accident_id)
		REFERENCES accidents_megatable(accident_id)
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
		REFERENCES accidents_megatable(accident_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


-- DATA INSERT --
SET SQL_SAFE_UPDATES = 0;
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

DELETE FROM twilight_information;
INSERT INTO twilight_information
SELECT 
	accident_id,
	sunrise_sunset,
	civil_twilight ,
	nautical_twilight,
	astronomical_twilight
FROM accidents_megatable;