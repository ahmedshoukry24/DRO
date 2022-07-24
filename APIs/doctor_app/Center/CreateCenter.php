<?php

include '../conn.php';

$doctorID = $_POST['DOC_ADMIN'];
$centerKey = $_POST['CENTER_KEY'];
$specialty = $_POST['SPECIALITY'];
$name = $_POST['NAME'];
$phone = $_POST['CENTER_PHONE'];
$address = $_POST['ADDRESS'];
$fee = $_POST['FEE'];
$finalResult = false;



$res = $conn->query("INSERT INTO `center` (`NAME`, `ADDRESS`, `CENTER_PHONE`, `SPECIALITY`, `FEE`, `DOC_ADMIN`,`CENTER_KEY`) 
	VALUES ('".$name."', '".$address."', '".$phone."', '".$specialty."', '".$fee."', '".$doctorID."','".$centerKey."');");

if($res){
	$centerID = $conn->query("SELECT CENTER_ID FROM center WHERE CENTER_KEY = '".$centerKey."';");
	$finalResult = $conn->query("INSERT INTO `doctor_center` (`DOCTOR_ID`, `CENTER_ID`, `ADMIN`) 
	VALUES ('".$doctorID."', '".$centerID->fetch_assoc()['CENTER_ID']."', 'A');");
}else{
	$finalResult = false;
}

echo json_encode($finalResult);


?>