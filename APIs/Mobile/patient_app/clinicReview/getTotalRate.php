<?php

include '../conn.php';

$clinicID = $_POST['clinic_id'];
$centerID = $_POST['center_id'];

$res = $conn->query("SELECT rate FROM `ratings` WHERE clinic_id = '".$clinicID."' AND `center_id` = '".$centerID."';");

$arr = array();

while ($row = $res->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);




?>