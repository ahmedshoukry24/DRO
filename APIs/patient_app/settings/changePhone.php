<?php

include '../conn.php';

$phone = $_POST['PHONE'];
$id = $_POST['PATIENT_ID'];

$res = $conn->query("UPDATE patient SET PHONE='".$phone."' WHERE patient.PATIENT_ID='".$id."';");

echo json_encode($res);

?>