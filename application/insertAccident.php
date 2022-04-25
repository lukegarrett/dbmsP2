<?php
if (isset($_POST['field_submit'])) {
    require_once("conn.php");
    $var_accident_id = $_POST['field_accident_id'];
	$var_start_time = $_POST['field_start_time'];
	// accident_id, start_time, end_time, severity, distance, description, timezone
	$var_end_time = $_POST['field_end_time'];
	$var_severity = $_POST['field_severity'];
    $var_distance = $_POST['field_distance'];
    $var_description = $_POST['field_description'];
    $var_timezone = $_POST['field_timezone'];

    $query = "CALL insertAccidentInfo(:accident_id, :start_time, :end_time, :severity, :distance, :description, :timezone)";

try
    {
    $st = $dbo->prepare ( $query );
    $st->bindValue( ":accident_id", $var_accident_id, PDO::PARAM_STR );
    $st->bindValue( ":start_time", $var_start_time, PDO::PARAM_STR );
	$st->bindValue( ":end_time", $var_end_time, PDO::PARAM_STR );
	$st->bindValue( ":severity", $var_severity, PDO::PARAM_INT );
	$st->bindValue( ":distance", $var_distance, PDO::PARAM_INT );
	$st->bindValue( ":description", $var_description, PDO::PARAM_STR );
	$st->bindValue( ":timezone", $var_timezone, PDO::PARAM_STR );
    $st->execute();

    }
    catch (PDOException $ex)
    { // Error in database processing.
      echo $sql . "<br>" . $error->getMessage(); // HTTP 500 - Internal Server Error
    }
}
?>
<html>
	<head>
		<title>Generic - Editorial by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
	</head>
	<body class="is-preload">

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Main -->
					<div id="main">
						<div class="inner">

							<!-- Header -->
								<header id="header">
									<a href="index.html" class="logo"><strong>US Accidents</strong> by Michael Dobson and Luke Garrett</a>
								</header>

							<!-- Content -->
								<section>
									<header class="main">
										<h1>Insert an accident</h1>
									</header>

									<h3> Insert an accident</h3>
									<form method="post">

									All fields are required!!
									
									<label for="accident_id">accident id</label>
									<input type="text" name="field_accident_id" id = "accident_id">
									
									<label for="start_time">start time</label>
									<input type="text" name="field_start_time" id = "start_time">
									
									<label for="end_time">end time</label>
									<input type="text" name="field_end_time" id = "end_time">
									
									<label for="severity">severity</label>
									<input type="text" name="field_severity" id = "severity">
									
									<label for="distance">distance</label>
									<input type="text" name="field_distance" id = "distance">
									
									<label for="description">description</label>
									<input type="text" name="field_description" id = "description">
									
									<label for="timezone">timezone</label>
									<input type="text" name="field_timezone" id = "timezone">

									<input type="submit" name="field_submit" value="Submit">
									</form>
									
									<?php
									if (isset($_POST['field_submit'])) {
										echo $_POST['field_description'];
										echo $_POST['field_timezone'];
									} ?>
									
								</section>
							<footer>
								<p><b>Creators: Michael Dobson and Luke Garrett</b> <br \>
									Template Proivded By:<br \>
									Editorial by HTML5 UP<br \>
									html5up.net | @ajlkn<br \>
									Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)</p>
									<p><a href="mailto:michael.w.dobson@vanderbilt.edu">michael.w.dobson@vanderbilt.edu</a> <br \>
									<a href="mailto:luke.e.garrett@vanderbilt.edu">luke.e.garrett@vanderbilt.edu</a>
								</p>
							</footer>
						</div>
						
					</div>
				<!-- Sidebar -->
				<div id="sidebar">
						<div class="inner">

							<!-- Search -->
								<section id="search" class="alt">
									<form method="post" action="#">
										<input type="text" name="query" id="query" placeholder="Search" />
									</form>
								</section>

							<!-- Menu -->
								<nav id="menu">
									<header class="major">
										<h2>Menu</h2>
									</header>
									<ul>
										<li><a href="index.html">Homepage</a></li>
										<li><a href="getAccident.php">Search Accidents</a></li>
										<li>
											<span class="opener">Get specific information</span>
											<ul>
												<li><a href="getAllInfo.php">Get Accident and Weather Information</a></li>
												<li><a href="getAccident.php">Get Accident Information</a></li>
												<li><a href="getWeatherInfo.php">Get Weather Information</a></li>
												<li><a href="getAvgWeatherSeverity.php">Get Average Weather Severity</a></li>
											</ul>
										</li>
										<li>
											<span class="opener">Add or Edit Accidents</span>
											<ul>
												<li><a href="insertAccident.php">Insert an accident</a></li>
												<li><a href="updateAccident.php">Update an accident</a></li>
												<li><a href="deleteAccident.php">Delete an accident</a></li>
											</ul>
										</li>
									</ul>
								</nav>

							<!-- Footer -->
								<footer id="footer">
									<p class="copyright">&copy; Untitled. All rights reserved. Demo Images: <a href="https://unsplash.com">Unsplash</a>. Design: <a href="https://html5up.net">HTML5 UP</a>.</p>
								</footer>

						</div>
					</div>
			</div>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

	</body>
	
</html>
<!--
	Editorial by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->