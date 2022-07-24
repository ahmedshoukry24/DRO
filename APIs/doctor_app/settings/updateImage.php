<?php

include '../conn.php';

$imageName = $_POST['PROFILE_PICTURE'];
$doctorID = $_POST['DOCTOR_ID'];

$res = $conn->query("UPDATE `doctor`
 SET `PROFILE_PICTURE` = '".$imageName."' WHERE `doctor`.`DOCTOR_ID` = '".$doctorID."';");

echo json_encode($res);

?>