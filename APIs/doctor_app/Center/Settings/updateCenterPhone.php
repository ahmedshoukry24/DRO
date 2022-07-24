<?php
include '../../conn.php';

$centerID = $_POST['CENTER_ID'];
$phone = $_POST['CENTER_PHONE'];


$res = $conn->query("UPDATE center SET CENTER_PHONE = '".$phone."' WHERE CENTER_ID = '".$centerID."';");

echo json_encode($res);

mysqli_close($conn);

?>