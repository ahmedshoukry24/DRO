<?php

include '../../conn.php';

$centerID = $_POST['CENTER_ID'];


$res = $conn->query("SELECT doctor.FIRST_NAME,doctor.LAST_NAME,doctor.DOCTOR_ID,doctor.SPECIALITY,doctor.TITLE,doctor.PHONE,doctor.GENDER,doctor.EMAIL,doctor.PROFILE_PICTURE FROM doctor_center,doctor,center WHERE doctor_center.DOCTOR_ID = doctor.DOCTOR_ID AND doctor_center.CENTER_ID =center.CENTER_ID AND doctor_center.CENTER_ID = '".$centerID."';");

$arr = array();

while ($row = $res->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);


?>