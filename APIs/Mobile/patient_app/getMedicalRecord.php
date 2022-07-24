<?php

include 'conn.php';

$patientID = $_POST['PATIENT_ID'];

$res=$conn->query("SELECT doctor.FIRST_NAME,doctor.LAST_NAME,medical_record.DOCTOR_ID,medical_record.DESCRIPTION,medical_record.DATE_TIME,medical_record.IMAGE FROM medical_record,doctor WHERE medical_record.PATIENT_ID = '".$patientID."' AND doctor.DOCTOR_ID = medical_record.DOCTOR_ID ORDER BY DATE_TIME DESC;");

$arr = array();

while ($row = $res->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);

?>