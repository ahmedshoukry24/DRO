<?php

include 'conn.php';

$patientID = $_POST['PATIENT_ID'];
$clinicID = $_POST['CLINIC_ID'];
$centerID = $_POST['CENTER_ID'];
$date = $_POST['DATE'];
$time = $_POST['TIME'];


$res = $conn->query("DELETE FROM `reservation` WHERE `reservation`.`PATIENT_ID` = '".$patientID."' AND `reservation`.`CLINIC_ID` = '".$clinicID."' AND `reservation`.`CENTER_ID` = '".$centerID."' AND `reservation`.`DATE` = '".$date."' AND `reservation`.`TIME` = '".$time."';");

echo json_encode($res);

?>