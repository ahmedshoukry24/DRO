<?php

include '../../conn.php';

$centerID = $_POST['CENTER_ID'];

$res = $conn->query("SELECT doctor.DOCTOR_ID, doctor.FIRST_NAME, doctor.LAST_NAME, doctor.SPECIALITY, doctor.TITLE, doctor.PHONE, doctor.GENDER, doctor.EMAIL, doctor.BIO, doctor.PROFILE_PICTURE, center.SPECIALITY from doctor,center WHERE doctor.SPECIALITY = center.SPECIALITY AND center.CENTER_ID = '".$centerID."'; ");

$arr = array();

while ($row = $res->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);

?>