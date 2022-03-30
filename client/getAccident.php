<?php
if (isset($_POST['field_submit'])) {
    require_once("conn.php");
    $var_accident = $_POST['field_accident'];
    $query = "SELECT * FROM accidents_megatable WHERE accident_id = :ph_accident";

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
    <link rel="stylesheet" type="text/css" href="project.css" />
  </head> 
  <body>
    <div id="navbar">
      <ul>
        <li><a href="index.html">Home</a></li>
        <li><a href="getAccident.php">Search Accident</a></li>
      </ul>
    </div>
    
    <h1> Search accident by accident_id</h1>
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
                    <th>accident_id</th>
                    <th>severity</th>
                    <th>description</th>

                  </tr>
                </thead>
                <tbody>
                  <?php foreach ($result as $row) { ?>
                
                    <tr>
                      <td><?php echo $row["accident_id"]; ?></td>
                      <td><?php echo $row["severity"]; ?></td>
                      <td><?php echo $row["description"]; ?></td>

                    </tr>
                  <?php } ?>
                </tbody>
            </table>
  
        <?php } else { ?>
          <h3>Sorry, no results found for accident <?php echo $_POST['field_accident']; ?>. </h3>
        <?php }
    } ?>


    
  </body>
</html>






