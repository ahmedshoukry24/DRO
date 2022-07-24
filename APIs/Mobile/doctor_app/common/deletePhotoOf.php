<?php

include '../conn.php';

$photoName = $_POST['PHOTO_NAME'];

$res = mysqli_query($conn,"DELETE FROM `photos` WHERE `photos`.`PHOTO_NAME` = '".$photoName."'");

echo json_encode($res);

mysqli_close($conn);



?>