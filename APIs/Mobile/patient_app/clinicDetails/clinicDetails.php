<?php
include '../conn.php';



$clinicID = $_POST['CLINIC_ID'];

$res = $conn->query("SELECT * FROM doctor, clinic 
WHERE doctor.DOCTOR_ID= clinic.DOCTOR_ID 
AND clinic.CLINIC_ID='".$clinicID."';");

$arr = array();

while ($row = $res->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);

?>