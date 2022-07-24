<?php

include 'conn.php';

$fName = $_POST['FIRST_NAME'];
$lName = $_POST['LAST_NAME'];
$email = $_POST['EMAIL'];
$password = $_POST['PASSWORD'];
$phone = $_POST['PHONE'];
$specialty = $_POST['SPECIALITY'];
$title = $_POST['TITLE'];
$birthDate = $_POST['BIRTH_DATE'];
$gender = $_POST['GENDER'];

$res = $conn->query("INSERT INTO doctor(FIRST_NAME,LAST_NAME,PHONE,GENDER,BIRTH_DATE,EMAIL,PASSWORD,SPECIALITY,TITLE) VALUES 
		( '".$fName."','".$lName."','".$phone."','".$gender."','".$birthDate."','".$email."','".$password."','".$specialty."','".$title."' )");

echo json_encode($res);


?>