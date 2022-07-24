<?php
include '../conn.php';

$centerID = $_POST['CENTER_ID'];
$clinicID = $_POST['CLINIC_ID'];

$res = $conn->query("SELECT * FROM `insurance` WHERE `CLINIC_ID` = '".$clinicID."' AND `CENTER_ID` = '".$centerID."'
");

$arr = array();

while ($row = $res->fetch_assoc()) {
	$arr[] = $row;
}
echo json_encode($arr);
