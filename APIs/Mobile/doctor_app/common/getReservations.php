<?php

include '../conn.php';

$clinicID = $_POST['CLINIC_ID'];
$centerID = $_POST['CENTER_ID'];

$resQuery = $conn->query("SELECT reservation.PATIENT_ID,reservation.CLINIC_ID,reservation.CHANNEL_ID,reservation.DATE,reservation.TIME, reservation.CENTER_ID,patient.FIRST_NAME,patient.LAST_NAME,patient.PHONE,patient.GENDER,patient.PROFILE_PICTURE  FROM reservation,patient WHERE CLINIC_ID = '".$clinicID."' AND CENTER_ID = '".$centerID."' AND reservation.DATE >= CURRENT_DATE() AND reservation.PATIENT_ID = patient.PATIENT_ID;");


$arr = array();

while ($row = $resQuery->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);

?>