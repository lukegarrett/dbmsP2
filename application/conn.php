<?php

$dbhost = '127.0.0.1'; // localhost
$dbuname = 'root';
$dbpass = '';
$dbname = 'us_accidents'; //Database name

$dbo = new PDO('mysql:host=' . $dbhost . ';port=3306;dbname=' . $dbname, $dbuname, $dbpass);

?>
