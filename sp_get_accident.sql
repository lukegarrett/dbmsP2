USE us_accidents;

DROP PROCEDURE IF EXISTS getAccident;

DELIMITER //

CREATE PROCEDURE getAccident(IN accident_id VARCHAR(20))
BEGIN

	SELECT accident_id, severity
    FROM accidents_megatable
    WHERE accident_id = accident_id;

END//

DELIMITER ;