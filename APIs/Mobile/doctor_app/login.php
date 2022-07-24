<?php

include 'conn.php';

$email 	  = $_POST['EMAIL'];
$password = $_POST['PASSWORD'];

$resQuey = $conn->query("SELECT * FROM doctor WHERE EMAIL = '".$email."' AND PASSWORD = '".$password."';");

$arr = array();

while ($row = $resQuey->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);

?>