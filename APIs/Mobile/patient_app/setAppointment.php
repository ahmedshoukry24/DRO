<?php
include 'conn.php';



$clinicID = $_POST['CLINIC_ID'];
$centerID = $_POST['CENTER_ID'];
$patientID = $_POST['PATIENT_ID'];
$date = $_POST['DATE'];
$time = $_POST['TIME'];
$channelID = $_POST['CHANNEL_ID'];

$res = $conn->query("INSERT INTO `reservation` (`PATIENT_ID`, `CLINIC_ID`,CENTER_ID, `DATE`, `TIME`,`CHANNEL_ID`)
 VALUES ('".$patientID."', '".$clinicID."','".$centerID."' , '".$date."', '".$time."','".$channelID."');");

echo json_encode($res);


?>