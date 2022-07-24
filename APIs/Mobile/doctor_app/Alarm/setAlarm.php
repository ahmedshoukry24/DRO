<?php

include '../conn.php';

$patientID = $_POST['PATIENT_ID'];
$title = $_POST['TITLE'];
$body = $_POST['BODY'];
$dateTime = $_POST['DATE_TIME'];

$res = $conn->query("INSERT INTO `alarm` (`PATIENT_ID`,`TITLE`, `BODY`, `DATE_TIME`, `STATUS`)
VALUES ('".$patientID."','".$title."', '".$body."','".$dateTime."', 'W');");

echo json_encode($res);

?>