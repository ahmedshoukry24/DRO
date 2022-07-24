<?php


include '../conn.php';

$id = $_POST['DOCTOR_ID'];
$phone = $_POST['PHONE'];

$res = $conn->query("UPDATE doctor SET PHONE='".$phone."' WHERE doctor.DOCTOR_ID='".$id."';");

echo json_encode($res);

?>