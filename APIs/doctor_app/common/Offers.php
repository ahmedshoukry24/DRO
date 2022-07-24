<?php

include '../conn.php';

$clinicID = $_POST['CLINIC_ID'];
$centerID = $_POST['CENTER_ID'];

$content = $_POST['CONTENT'];
$figureName = $_POST['FIGURE_NAME'];

$dateTime =$_POST['DATE_TIME']; 



$res = mysqli_query($conn,"INSERT INTO `offers`(`CLINIC_ID`, `CENTER_ID`, `CONTENT`, `FIGURE_NAME`, `DATE_TIME`) VALUES ('".$clinicID."','".$centerID."','".$content."','".$figureName."','".$dateTime."')");

echo json_encode($res);

?>