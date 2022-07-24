<?php

include '../conn.php';

$name = $_POST['CLINIC_NAME'];
$phone = $_POST['PHONE'];
$address = $_POST['ADDRESS'];
$doctorID = $_POST['DOCTOR_ID'];
$clinicKey = $_POST['CLINIC_KEY'];
$fee = $_POST['FEE'];


$res = $conn->query("INSERT INTO `clinic` (`CLINIC_NAME`, `DOCTOR_ID`, `ADDRESS`, `CLINIC_PHONE`,`CLINIC_KEY`,`FEE`) 
	VALUES ('".$name."' , '".$doctorID."', '".$address."','".$phone."','".$clinicKey."','".$fee."');");

echo json_encode($res);

?>