<?php
include '../conn.php';

 $clinicID = $_POST['CLINIC_ID'];
 $centerID = $_POST['CENTER_ID'];
 $image = $_POST['PHOTO_NAME'];

$res = mysqli_query($conn,"INSERT INTO `photos` (`CLINIC_ID`, `CENTER_ID`, `PHOTO_NAME`) VALUES ('".$clinicID."', '".$centerID."', '".$image."');");

mysqli_free_result($res);

mysqli_close($conn);

echo json_encode($res);


?>