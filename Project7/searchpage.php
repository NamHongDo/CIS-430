<?php
 $con = mysqli_connect("localhost", "root", "") or die("Error connecting to database: ".mysqli_error());
 mysqli_select_db($con, "Company") or die(mysqli_error());
?>
 <!DOCTYPE HTML>
<html>
 <p><body>
 <h3>Search Company Database</h3>
 <p>Search by last name</p>
 <form method="post" action="search.php?go" id="searchform">
 <input type="text" name="name">
 <input type="submit" name="submit" value="Search">
 </form>
 <form method="post" action="search.php" id="resetform">
 <input type="submit" name="reset" value= "Reset">
 <p>Enter search condition</p>
 </form>
 </body>
 </html>
 </p> 
