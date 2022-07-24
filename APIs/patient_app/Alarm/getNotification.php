<?php
include '../conn.php';

$patientID = $_POST['PATIENT_ID'];


$res = $conn->query("SELECT `ALARM_ID`,`TITLE`,`BODY`,`STATUS` FROM alarm WHERE `PATIENT_ID` = '".$patientID."' AND `STATUS` = 'W'");

$arr = array();

while ($row = $res->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);


?>