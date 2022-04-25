USE us_accidents;
-- location table --
DROP TABLE IF EXISTS location_info;
CREATE TABLE location_info (
	accident_id VARCHAR(20) NOT NULL,
    city VARCHAR(15),
    county VARCHAR(15),
    state VARCHAR(2),
    zipcode VARCHAR(5),
    country VARCHAR(2),
    timezone VARCHAR(15),		
    
	PRIMARY KEY (accident_id),
    CONSTRAINT fk_id_1 FOREIGN KEY (accident_id)
		REFERENCES accidents_megatable(accident_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=INNODB;

DROP TABLE IF EXISTS weather_info;
CREATE TABLE weather_info (
	accident_id VARCHAR(20) NOT NULL,
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
    
	PRIMARY KEY (accident_id),
    CONSTRAINT fk_id_2 FOREIGN KEY (accident_id)
		REFERENCES accidents_megatable(accident_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=INNODB;

DROP TABLE IF EXISTS severity_and_time_info;
CREATE TABLE severity_and_time_info (
	accident_id VARCHAR(20) NOT NULL,
	severity TINYINT,
    start_time DATETIME,
    end_time DATETIME,	
    
	PRIMARY KEY (accident_id),
    CONSTRAINT fk_id_3 FOREIGN KEY (accident_id)
		REFERENCES accidents_megatable(accident_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=INNODB;
-- inserts --

INSERT INTO location_info 
(accident_id,
    city,
    county,
    state,
    zipcode,
    country,
    timezone)                                    
SELECT 
accident_id,
    city,
    county,
    state,
    zipcode,
    country,
    timezone 
FROM accidents_megatable
WHERE accidents_megatable.accident_id = accident_id;

INSERT INTO weather_info 
(accident_id,
	weather_timestamp,
    temperature,
    wind_chill,
    humidity,
    pressure,
    visibility,
    wind_direction,
    wind_speed,
    precipitation,
    weather_condition)                                    
SELECT 
accident_id,
	weather_timestamp,
    temperature,
    wind_chill,
    humidity,
    pressure,
    visibility,
    wind_direction,
    wind_speed,
    precipitation,
    weather_condition 
FROM accidents_megatable
WHERE accidents_megatable.accident_id = accident_id;

INSERT INTO severity_and_time_info 
(accident_id,
	severity,
    start_time,
    end_time)                                    
SELECT 
accident_id,
	severity,
    start_time,
    end_time
FROM accidents_megatable
WHERE accidents_megatable.accident_id = accident_id;