<?php

include '../conn.php';

$doctorID = $_POST['doctorID'];

$res = $conn->query('SELECT doctor_center.DOCTOR_ID,doctor_center.CENTER_ID,doctor_center.ADMIN,center.NAME,center.ADDRESS,center.CENTER_PHONE,center.CENTER_PHONE,center.CENTER_PHOTO,center.FEE,center.DOC_ADMIN  FROM doctor_center,center WHERE doctor_center.DOCTOR_ID = "'.$doctorID.'" AND doctor_center.CENTER_ID = center.CENTER_ID');
$arr = array();

while ($row = $res->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);

?>