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
    weather_timestamp DATETIME,
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

LOAD DATA
	LOCAL INFILE 'C:/Users/micha/Downloads/US_Accidents_Dec21_updated.csv' 
	INTO TABLE accidents_megatable 
	FIELDS TERMINATED BY ',' 
	ENCLOSED BY '"'
	LINES TERMINATED BY '\n';