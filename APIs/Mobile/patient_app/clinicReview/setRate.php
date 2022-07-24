<?php

include '../conn.php';

$clinicID = $_POST['clinic_id'];
$centerID = $_POST['center_id'];
$patientID  = $_POST['patient_id']; 
$rate = $_POST['rate'];

$conn->query("DELETE FROM `ratings` WHERE `patient_id` = '".$patientID."' AND `clinic_id` = '".$clinicID."' AND `center_id` = '".$centerID."';");

$conn->query("INSERT INTO `ratings` (`patient_id`, `clinic_id`, `rate`, `center_id`)
 VALUES ('".$patientID."', '".$clinicID."', '".$rate."','".$centerID."');");

?>