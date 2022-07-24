<?php


include 'conn.php';

$cat = $_POST['cat'];

if($cat == '0'){
	$res = $conn->query("SELECT * FROM doctor, clinic 
WHERE doctor.DOCTOR_ID = clinic.DOCTOR_ID AND doctor.SPECIALITY IS NOT NULL");
}else{
	$res = $conn->query("SELECT * FROM doctor, clinic 
WHERE doctor.DOCTOR_ID = clinic.DOCTOR_ID AND doctor.SPECIALITY = '".$cat."'");
}



$arr = array();

while ($row = $res->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);



?>