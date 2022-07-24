<?php

include '../../conn.php';

$centerID = $_POST['CENTER_ID'];
$image = $_POST['CENTER_PHOTO'];

$query = "UPDATE center SET CENTER_PHOTO = '".$image."' WHERE CENTER_ID = '".$centerID."';";

echo json_encode(mysqli_query($conn,$query));

?>