<?php
include '../conn.php';

$clinicID = $_POST['CLINIC_ID'];
$centerID = $_POST['CENTER_ID'];
$insurance = $_POST['INSUR_NAME'];

$res = $conn->query("INSERT INTO `insurance` (`CLINIC_ID`, `CENTER_ID`, `INSUR_NAME`) VALUES ('".$clinicID."', '".$centerID."', '".$insurance."');");

echo json_encode($res);
?>