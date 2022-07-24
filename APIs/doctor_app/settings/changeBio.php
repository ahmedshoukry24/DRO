<?php
include '../conn.php';

$bio = $_POST['BIO'];
$doctorID = $_POST['DOCTOR_ID'];

$res = mysqli_query($conn,"UPDATE doctor SET BIO ='".$bio."' WHERE DOCTOR_ID = '".$doctorID."'");

echo json_encode($res);


?>