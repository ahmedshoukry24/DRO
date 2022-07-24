<?php

include 'conn.php';


$doctorID = $_POST['DOCTOR_ID'];

$resQuery = $conn->query("SELECT * FROM doctor WHERE DOCTOR_ID = '".$doctorID."'");

$arr = array();

while ($row = $resQuery->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);



?>