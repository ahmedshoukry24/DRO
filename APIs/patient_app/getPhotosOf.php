<?php
include 'conn.php';

$clinicID = $_POST['CLINIC_ID'];
$centerID = $_POST['CENTER_ID'];

$query = mysqli_query($conn,"SELECT PHOTO_NAME FROM `photos` WHERE `CLINIC_ID` ='".$clinicID."' AND `CENTER_ID` = '".$centerID."';");

echo json_encode(mysqli_fetch_all($query,MYSQLI_ASSOC));

?>