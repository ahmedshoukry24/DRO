<?php


include '../conn.php';


$fName = $_POST['FIRST_NAME'];
$lName = $_POST['LAST_NAME'];
$id = $_POST['PATIENT_ID'];

$res=$conn->query("UPDATE patient SET FIRST_NAME='".$fName."',LAST_NAME ='".$lName."' WHERE patient.PATIENT_ID='".$id."';");

echo json_encode($res);


?>