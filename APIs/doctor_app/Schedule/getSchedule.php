<?php

include '../conn.php';


$clinicID = $_POST['CLINIC_ID'];
$centerID = $_POST['CENTER_ID'];

$res = $conn->query("SELECT * FROM week_days WHERE CLINIC_ID = '".$clinicID."' AND CENTER_ID = '".$centerID."'");

$arr = array();

while($row = $res->fetch_assoc()){
	$arr[] = $row;
}

echo json_encode($arr);

?>