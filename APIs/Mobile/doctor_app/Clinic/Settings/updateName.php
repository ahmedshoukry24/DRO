<?php

include '../../conn.php';

$clinicID = $_POST['CLINIC_ID'];
$clinicName = $_POST['CLINIC_NAME'];

$res = mysqli_query($conn,"UPDATE clinic SET `CLINIC_NAME` = '".$clinicName."' WHERE CLINIC_ID = '".$clinicID."'");


echo json_encode($res);


mysqli_close($conn);



?>