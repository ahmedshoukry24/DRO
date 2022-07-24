<?php

include 'conn.php';

$clinicID = $_POST['CLINIC_ID'];
$date=		$_POST['DATE'];
$centerID = $_POST['CENTER_ID'];

$res = $conn->query("SELECT TIME from reservation WHERE CLINIC_ID = '".$clinicID."' AND DATE = '".$date."' AND CENTER_ID = '".$centerID."';");

$arr = array();

while ($row = $res->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);

?>