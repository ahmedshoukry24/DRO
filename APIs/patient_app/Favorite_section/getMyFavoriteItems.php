<?php

include '../conn.php';


$patientID = $_POST['PATIENT_ID'];

$firstResult = $conn->query("SELECT * FROM bookmark_list WHERE bookmark_list.PATIENT_ID ='".$patientID."';");

$arr = array();

while ($row = $firstResult->fetch_assoc()) {
	if($row['CLINIC_ID'] == '-1'){
		#work on center table
		$center = $conn->query(" SELECT * FROM `center` WHERE CENTER_ID = '".$row['CENTER_ID']."' ");
		$arr[] = $center->fetch_assoc();
	}else{
		#work on clinic table
		$clinic = $conn->query("SELECT clinic.CLINIC_ID,clinic.CLINIC_NAME,clinic.ADDRESS,clinic.CLINIC_PHONE,clinic.FEE,doctor.DOCTOR_ID,doctor.FIRST_NAME,doctor.LAST_NAME,doctor.SPECIALITY,doctor.TITLE,doctor.PROFILE_PICTURE FROM clinic, doctor WHERE clinic.CLINIC_ID = '".$row['CLINIC_ID']."' AND doctor.DOCTOR_ID = clinic.DOCTOR_ID");
		$arr[] = $clinic->fetch_assoc();
	}
}

echo json_encode($arr);


?>