<?php

include '../conn.php';

$patientID = $_POST['PATIENT_ID'];
$imageName = $_POST['PROFILE_PICTURE'];


$res = $conn->query("UPDATE `patient` SET `PROFILE_PICTURE` = '".$imageName."' WHERE `patient`.`PATIENT_ID` = '".$patientID."';");

echo json_encode($res);


?>