<?php


include 'conn.php';

$fName = $_POST['FIRST_NAME'];
$lName = $_POST['LAST_NAME'];
$phone = $_POST['PHONE'];
$email = $_POST['EMAIL'];
$password = $_POST['PASSWORD'];
$birthDate = $_POST['BIRTH_DATE'];
$gender = $_POST['GENDER'];

$res = $conn->query("INSERT INTO patient(FIRST_NAME,LAST_NAME,PHONE,GENDER,BIRTH_DATE,EMAIL,PASSWORD) VALUES 
		( '".$fName."','".$lName."','".$phone."','".$gender."','".$birthDate."','".$email."','".$password."' )");

echo json_encode($res);

?>