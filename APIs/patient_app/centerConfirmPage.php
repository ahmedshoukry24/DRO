<?php

include 'conn.php';

$centerID = $_POST['CENTER_ID'];
$patientID = $_POST['PATIENT_ID'];

$res = $conn->query("SELECT center.NAME,center.CENTER_PHONE,center.FEE,patient.FIRST_NAME,patient.LAST_NAME,patient.PHONE as PATIENT_PHONE FROM patient, center WHERE center.CENTER_ID = '".$centerID."' AND patient.PATIENT_ID = '".$patientID."'");


echo json_encode($res->fetch_assoc());

?>