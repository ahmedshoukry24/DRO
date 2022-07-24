<?php
include 'conn.php';


$patientID = $_POST['PATIENT_ID'];
$doctorID = $_POST['DOCTOR_ID'];
$description = $_POST['DESCRIPTION'];
$dateTime = $_POST['DATE_TIME'];
$image = $_POST['IMAGE'];

$res = $conn->query("INSERT INTO `medical_record` (`PATIENT_ID`, `DOCTOR_ID`, `DESCRIPTION`, `DATE_TIME`, `IMAGE`) VALUES ('".$patientID."', '".$doctorID."', '".$description."', '".$dateTime."', '".$image."');");

echo json_encode($res);


?>