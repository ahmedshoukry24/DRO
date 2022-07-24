<?php

include '../../conn.php';

$centerID = $_POST['CENTER_ID'];
$doctorID = $_POST['DOCTOR_ID'];

$res = $conn->query("INSERT INTO `doctor_center` (`DOCTOR_ID`, `CENTER_ID`, `ADMIN`) 
	VALUES ('".$doctorID."', '".$centerID."', 'E');");

echo json_encode($res);

?>