<?php

include 'conn.php';

$centerID = $_POST['CENTER_ID'];

$res = $conn->query("SELECT doctor.DOCTOR_ID,doctor.FIRST_NAME,doctor.LAST_NAME,doctor.PHONE as DOCTOR_PHONE,doctor.GENDER,doctor.BIO,doctor.PROFILE_PICTURE FROM doctor_center, doctor WHERE doctor.DOCTOR_ID = doctor_center.DOCTOR_ID AND doctor_center.CENTER_ID = '".$centerID."'");

$arr = array();


while ($row = $res->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);

?>