<!DOCTYPE html>

<html>
<head>
 <title>Search results</title>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <link rel="stylesheet" type="text/css" href="style.css"/>
</head>
<h3>COMPANY WEBSITE</h3>
  <table border="1" style= "background-color: #61ed15; color: #161a9b; margin:5 auto;" >
  <thead>
        <tr>
          <th>First Name</th>
          <th>Last Name</th>
          <th>Sex</th>
          <th>DNO</th>
        </tr>
      </thead>
</table>
<body>
<?php
 if (isset($_POST['name'])){
	$query = $_POST['name'];
	$con = mysqli_connect("localhost","root","") or exit(mysql_error());
	mysqli_select_db($con,"company");
	$sql = mysqli_query($con, "SELECT * FROM employee
	WHERE (`Lname` LIKE '%".$query."%')") or exit(mysql_error());	
	if (mysqli_num_rows($sql) > 0) {
	// if one or more rows are returned do following
	while ($row = mysqli_fetch_array($sql)) {
		echo $row['FName']." " .$row['LName']." " .$row['Sex'] . " " .$row['DNo'] ."</br>";
		}
	}
 else{ // if there is no matching rows do following
 echo "No results";
 }
 }
 else{
 echo 'Enter search conditions';
 }  
?>
</body>
</html>
