
<!--
	Editorial by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<?php
if (isset($_POST['field_submit'])) {
    require_once("conn.php");
    $var_accident = $_POST['field_accident'];
    $query = "CALL getWeatherSeverity(:ph_minimum)";

try
    {
      $prepared_stmt = $dbo->prepare($query);
      $prepared_stmt->bindValue(':ph_minimum', $var_accident, PDO::PARAM_STR);
      $prepared_stmt->execute();
      $result = $prepared_stmt->fetchAll();

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
										<h1>Get Average Weather Severity</h1>
									</header>

									<h3>Please input minimum severity level (1-5)</h3>
									<form method="post">
										<label for="minimum sev">Minimum Severity</label>
										<input type="text" name="field_accident" id = "accident_id">
										<input type="submit" name="field_submit" value="Submit">
									</form>
									
									<?php
									if (isset($_POST['field_submit'])) {
										if ($result && $prepared_stmt->rowCount() > 0) { ?>
											<h2>Results</h2>
											<table>
												<thead>
												<tr>
													<th>Weather Condition</th>
													<th>Average Severity</th>
												</tr>
												</thead>
												<tbody>
												<?php foreach ($result as $row) { ?>
												
													<tr>
														<td><?php echo $row["weather_condition"]; ?></td>
														<td><?php echo $row["average_severity"]; ?></td>
													</tr>
												<?php } ?>
												</tbody>
											</table>
								
										<?php } else { ?>
										<h3>Sorry, no results found for accident <?php echo $_POST['field_accident']; ?>. </h3>
										<?php }
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
                                                <li><a href="getAccident.php">Get Accident Info</a></li>
												<li><a href="getWeatherInfo.php">Get Weather Info</a></li>
												<li><a href="#">Get Geo Location Info</a></li>
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
