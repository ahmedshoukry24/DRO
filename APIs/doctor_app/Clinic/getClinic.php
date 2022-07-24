<?php

include '../conn.php';

$clinicKey = $_POST['CLINIC_KEY'];

$res = $conn->query("SELECT * FROM `clinic` WHERE `CLINIC_KEY` = '".$clinicKey."';");

$arr = array();

while ($row = $res->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);


?>