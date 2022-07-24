<?php

include "../conn.php";

$doctorID = $_POST['DOCTOR_ID'];

$res = $conn->query("SELECT clinic.`CLINIC_ID`,clinic.`CLINIC_NAME`,clinic.`DOCTOR_ID`,clinic.`ADDRESS`,clinic.`CLINIC_PHONE`,doctor.FIRST_NAME,doctor.LAST_NAME,doctor.PROFILE_PICTURE FROM doctor, clinic WHERE clinic.DOCTOR_ID = doctor.DOCTOR_ID AND doctor.DOCTOR_ID = '".$doctorID."'");

$arr = array();

while ($row = $res->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);



?>