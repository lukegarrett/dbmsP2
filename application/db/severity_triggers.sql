-- Michael Dobson and Luke Garrett --
-- Vanderbilt University --
-- CS 3265: Database Management Systems --
-- US Accidents Script File --
-- LOAD DATA SCRIPT 3 --
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