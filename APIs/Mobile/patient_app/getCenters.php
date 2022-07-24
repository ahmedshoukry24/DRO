<?php

include 'conn.php';


$cat = $_POST['cat'];

if($cat == '0'){
	$res = $conn->query("SELECT * FROM `center` WHERE `SPECIALITY` IS NOT NULL");
}else{
	$res = $conn->query("SELECT * FROM `center` WHERE `SPECIALITY` = '".$cat."'");

}

$arr = array();

while ($row = $res->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);


?>