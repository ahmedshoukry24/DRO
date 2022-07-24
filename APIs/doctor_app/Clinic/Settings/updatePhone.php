<?php

include '../../conn.php';

$clinicID = $_POST['CLINIC_ID'];
$clinicPhone = $_POST['CLINIC_PHONE'];

$res = mysqli_query($conn,"UPDATE clinic SET `CLINIC_PHONE` = '".$clinicPhone."' WHERE CLINIC_ID = '".$clinicID."'");


echo json_encode($res);


mysqli_close($conn);



?>