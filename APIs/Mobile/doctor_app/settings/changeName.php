<?php


include '../conn.php';


$fName = $_POST['FIRST_NAME'];
$lName = $_POST['LAST_NAME'];
$id = $_POST['DOCTOR_ID'];

$res=$conn->
	query("UPDATE doctor SET FIRST_NAME='".$fName."',LAST_NAME ='".$lName."' WHERE doctor.DOCTOR_ID='".$id."';");

echo json_encode($res);


?>