<?php

include '../conn.php';

$patientID = $_POST['PATIENT_ID'];
$clinicID = $_POST['CLINIC_ID'];
$centerID = $_POST['CENTER_ID'];


$conn->query("DELETE FROM bookmark_list 
	WHERE `PATIENT_ID` = '".$patientID."'  AND `CLINIC_ID` ='".$clinicID."' AND CENTER_ID = '".$centerID."' ;");

?>