<?php

include '../conn.php';

$centerID = $_POST['CENTER_ID'];
$clinicID = $_POST['CLINIC_ID'];

$res = mysqli_query($conn,"SELECT `PHOTO_NAME` FROM `photos` WHERE `CENTER_ID` = '".$centerID."' AND `CLINIC_ID` = '".$clinicID."';");

$arr = mysqli_fetch_all($res,MYSQLI_ASSOC);

mysqli_free_result($res);

mysqli_close($conn);

echo json_encode($arr);


?>