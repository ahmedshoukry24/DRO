<?php

include 'conn.php';

$patientID = $_POST['PATIENT_ID'];

$resQuery = $conn->query("SELECT * FROM patient WHERE PATIENT_ID = '".$patientID."'");

$arr = array();

while ($row = $resQuery->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);

?>