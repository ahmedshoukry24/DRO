<?php
include 'conn.php';

$centerID = $_POST['CENTER_ID'];

$query = mysqli_query($conn,"SELECT `CENTER_PHOTO` FROM center WHERE `CENTER_ID` = '".$centerID."';");

$res = mysqli_fetch_all($query,MYSQLI_ASSOC);

echo json_encode($res);

?>