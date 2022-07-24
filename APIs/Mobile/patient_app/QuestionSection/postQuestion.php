<?php
include '../conn.php';

$patientID = $_POST['PATIENT_ID'];
$specialty = $_POST['SPECIALITY'];
$question = $_POST['QUESTION'];
$date = $_POST['DATE'];

$res = $conn->query("INSERT INTO `questions` (`PATIENT_ID`, `SPECIALITY`, `QUESTION`, `DATE`)
 VALUES ('".$patientID."', '".$specialty."', '".$question."', '".$date."');");

echo json_encode($res);


?>