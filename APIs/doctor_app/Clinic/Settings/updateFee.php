<?php

include '../../conn.php';

$clinicID = $_POST['CLINIC_ID'];
$fee = $_POST['FEE'];

$res = mysqli_query($conn,"UPDATE clinic SET `FEE` = '".$fee."' WHERE CLINIC_ID = '".$clinicID."'");


echo json_encode($res);


mysqli_close($conn);



?>