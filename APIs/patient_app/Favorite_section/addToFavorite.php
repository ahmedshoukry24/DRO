<?php

include '../conn.php';


$patientID = $_POST['PATIENT_ID'];
$clinicID = $_POST['CLINIC_ID'];
$centerID = $_POST['CENTER_ID'];


$conn -> query("INSERT INTO `bookmark_list` (`PATIENT_ID`, `CLINIC_ID`, CENTER_ID)
 VALUES ('".$patientID."', '".$clinicID."','".$centerID."');");


?>