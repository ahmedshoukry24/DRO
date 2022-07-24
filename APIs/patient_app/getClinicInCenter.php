<?php

include 'conn.php';

$doctorID = $_POST['DOCTOR_ID'];

$res = $conn->query("SELECT `CLINIC_NAME`,`CLINIC_ID` FROM `clinic` WHERE `DOCTOR_ID` = '".$doctorID."'");

$arr = array();

while ($row = $res->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);


?>