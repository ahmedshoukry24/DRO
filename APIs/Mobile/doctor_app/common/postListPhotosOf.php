<?php
include '../conn.php';

$clinicID = $_POST['CLINIC_ID'];
$centerID = $_POST['CENTER_ID'];
$images = json_decode($_POST['images']);


foreach ($images as $image) {
	mysqli_query($conn,"INSERT INTO `photos` (`CLINIC_ID`, `CENTER_ID`, `PHOTO_NAME`) VALUES ('".$clinicID."', '".$centerID."', '".$image."');");
}

echo json_encode(true);

?>