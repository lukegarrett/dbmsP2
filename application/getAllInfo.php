<?php
if (isset($_POST['field_submit'])) {
    require_once("conn.php");
    $var_accident = $_POST['field_accident'];
    $query = "CALL getAllInfo(:ph_accident)";

try
    {
      $prepared_stmt = $dbo->prepare($query);
      $prepared_stmt->bindValue(':ph_accident', $var_accident, PDO::PARAM_STR);
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
										<h1>Search an accident</h1>
									</header>

									<h3> Search accident by accident_id</h3>
									<form method="post">

									<label for="accident_id">accident</label>
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
													<th>Accident ID</th>
													<th>Severity</th>
													<th>Description</th>

													<th>Temperature</th>
													<th>Wind Chill</th>
                                                    <th>Humidity</th>
                                                    <th>Pressure</th>
                                                    <th>Visibility</th>
                                                    <th>Wind Direction</th>
                                                    <th>Wind Speed</th>
                                                    <th>Precipitation</th>
                                                    <th>Weather Condition</th>
                                                    <th>Weather Timestamp</th>
												</tr>
												</thead>
												<tbody>
												<?php foreach ($result as $row) { ?>
												
													<tr>
													<td><?php echo $row["accident_id"]; ?></td>
													<td><?php echo $row["severity"]; ?></td>
													<td><?php echo $row["description"]; ?></td>
													<td><?php echo $row["accident_id"]; ?></td>
													<td><?php echo $row["temperature"]; ?></td>
													<td><?php echo $row["wind_chill"]; ?></td>
                                                    <td><?php echo $row["humidity"]; ?></td>
                                                    <td><?php echo $row["pressure"]; ?></td>
                                                    <td><?php echo $row["visibility"]; ?></td>
                                                    <td><?php echo $row["wind_direction"]; ?></td>
                                                    <td><?php echo $row["wind_speed"]; ?></td>
                                                    <td><?php echo $row["precipitation"]; ?></td>
                                                    <td><?php echo $row["weather_condition"]; ?></td>
                                                    <td><?php echo $row["weather_timestamp"]; ?></td>

													</tr>
												<?php } ?>
												</tbody>
											</table>
								
										<?php } else { ?>
										<h3>Sorry, no results found for accident <?php echo $_POST['field_accident']; ?>. </h3>
										<?php }
									} ?>
<!-- 
									<p>Donec eget ex magna. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque venenatis dolor imperdiet dolor mattis sagittis. Praesent rutrum sem diam, vitae egestas enim auctor sit amet. Pellentesque leo mauris, consectetur id ipsum sit amet, fergiat. Pellentesque in mi eu massa lacinia malesuada et a elit. Donec urna ex, lacinia in purus ac, pretium pulvinar mauris. Curabitur sapien risus, commodo eget turpis at, elementum convallis elit. Pellentesque enim turpis, hendrerit.</p>
									<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis dapibus rutrum facilisis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Etiam tristique libero eu nibh porttitor fermentum. Nullam venenatis erat id vehicula viverra. Nunc ultrices eros ut ultricies condimentum. Mauris risus lacus, blandit sit amet venenatis non, bibendum vitae dolor. Nunc lorem mauris, fringilla in aliquam at, euismod in lectus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. In non lorem sit amet elit placerat maximus. Pellentesque aliquam maximus risus, vel sed vehicula.</p>
									<p>Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque venenatis dolor imperdiet dolor mattis sagittis. Praesent rutrum sem diam, vitae egestas enim auctor sit amet. Pellentesque leo mauris, consectetur id ipsum sit amet, fersapien risus, commodo eget turpis at, elementum convallis elit. Pellentesque enim turpis, hendrerit tristique lorem ipsum dolor.</p>

									<hr class="major" />

									<h2>Interdum sed dapibus</h2>
									<p>Donec eget ex magna. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque venenatis dolor imperdiet dolor mattis sagittis. Praesent rutrum sem diam, vitae egestas enim auctor sit amet. Pellentesque leo mauris, consectetur id ipsum sit amet, fergiat. Pellentesque in mi eu massa lacinia malesuada et a elit. Donec urna ex, lacinia in purus ac, pretium pulvinar mauris. Curabitur sapien risus, commodo eget turpis at, elementum convallis elit. Pellentesque enim turpis, hendrerit.</p>
									<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis dapibus rutrum facilisis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Etiam tristique libero eu nibh porttitor fermentum. Nullam venenatis erat id vehicula viverra. Nunc ultrices eros ut ultricies condimentum. Mauris risus lacus, blandit sit amet venenatis non, bibendum vitae dolor. Nunc lorem mauris, fringilla in aliquam at, euismod in lectus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. In non lorem sit amet elit placerat maximus. Pellentesque aliquam maximus risus, vel sed vehicula. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque venenatis dolor imperdiet dolor mattis sagittis. Praesent rutrum sem diam, vitae egestas enim auctor sit amet. Pellentesque leo mauris, consectetur id ipsum sit amet, fersapien risus, commodo eget turpis at, elementum convallis elit. Pellentesque enim turpis, hendrerit tristique lorem ipsum dolor.</p>

									<hr class="major" />

									<h2>Magna etiam veroeros</h2>
									<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis dapibus rutrum facilisis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Etiam tristique libero eu nibh porttitor fermentum. Nullam venenatis erat id vehicula viverra. Nunc ultrices eros ut ultricies condimentum. Mauris risus lacus, blandit sit amet venenatis non, bibendum vitae dolor. Nunc lorem mauris, fringilla in aliquam at, euismod in lectus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. In non lorem sit amet elit placerat maximus. Pellentesque aliquam maximus risus, vel sed vehicula.</p>
									<p>Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque venenatis dolor imperdiet dolor mattis sagittis. Praesent rutrum sem diam, vitae egestas enim auctor sit amet. Pellentesque leo mauris, consectetur id ipsum sit amet, fersapien risus, commodo eget turpis at, elementum convallis elit. Pellentesque enim turpis, hendrerit tristique lorem ipsum dolor.</p>

									<hr class="major" />

									<h2>Lorem aliquam bibendum</h2>
									<p>Donec eget ex magna. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque venenatis dolor imperdiet dolor mattis sagittis. Praesent rutrum sem diam, vitae egestas enim auctor sit amet. Pellentesque leo mauris, consectetur id ipsum sit amet, fergiat. Pellentesque in mi eu massa lacinia malesuada et a elit. Donec urna ex, lacinia in purus ac, pretium pulvinar mauris. Curabitur sapien risus, commodo eget turpis at, elementum convallis elit. Pellentesque enim turpis, hendrerit.</p>
									<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis dapibus rutrum facilisis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Etiam tristique libero eu nibh porttitor fermentum. Nullam venenatis erat id vehicula viverra. Nunc ultrices eros ut ultricies condimentum. Mauris risus lacus, blandit sit amet venenatis non, bibendum vitae dolor. Nunc lorem mauris, fringilla in aliquam at, euismod in lectus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. In non lorem sit amet elit placerat maximus. Pellentesque aliquam maximus risus, vel sed vehicula.</p> -->

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