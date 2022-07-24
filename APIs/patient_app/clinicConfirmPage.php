<?php

include 'conn.php';


$clinicID = $_POST['CLINIC_ID'];
$patientID = $_POST['PATIENT_ID'];

$res = $conn->query("SELECT clinic.CLINIC_NAME,clinic.ADDRESS,clinic.CLINIC_PHONE,clinic.FEE,clinic.CLINIC_ID,doctor.SPECIALITY,doctor.FIRST_NAME AS DR_F_N,doctor.LAST_NAME AS DR_L_N,doctor.DOCTOR_ID,doctor.PROFILE_PICTURE,patient.PATIENT_ID,patient.FIRST_NAME,patient.LAST_NAME,patient.PHONE AS PATIENT_PHONE FROM doctor, clinic, patient WHERE clinic.DOCTOR_ID = doctor.DOCTOR_ID AND patient.PATIENT_ID = '".$patientID."' AND clinic.CLINIC_ID = '".$clinicID."';");

$arr = array();

while ($row = $res->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);


?>