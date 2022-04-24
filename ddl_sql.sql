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
    
-- 		IF sql_error = FALSE THEN
-- 			COMMIT;
-- 			SELECT 'The accident was deleted.';
-- 		ELSE
-- 			ROLLBACK;
-- 			SELECT 'The transaction was rolled back.';
-- 		END IF;
END//
DELIMITER ;

SELECT *
FROM accident_information;

CALL insertAccident('A-', '3', '2016-02-08 00:37:08', '2016-02-08 06:37:08', '40', '-83', '40', '-83', '3', 'Between Sawmill Rd/Exit 20 and OH-315/Olentangy Riv Rd/Exit 22 - Accident.', '0', 'Outerbelt E', 'R', 'Dublin', 'Franklin', 'OH', '43017', 'US', 'US/Eastern', 'KOSU', '2016-02-08 00:53:00', '42', '36', '58', '30', '10', 'SW', '10', '0', 'Light Rain', 'False', 'False', 'False', 'False', 'False', 'False', 'False', 'False', 'False', 'False', 'False', 'False', 'False', 'Night', 'Night', 'Night', 'Night');
