<?php

include '../conn.php';

$clinicID = $_POST["CLINIC_ID"];
$sat1 = $_POST["SAT_START"];
$sat2 = $_POST["SAT_END"];
$sun1 = $_POST["SUN_START"];
$sun2 = $_POST["SUN_END"];
$mon1 = $_POST['MON_START'];
$mon2 = $_POST["MON_END"];
$tue1 = $_POST["TUES_START"];
$tue2 = $_POST["TUES_END"];
$wed1 = $_POST["WED_START"];
$wed2 = $_POST["WED_END"];
$thu1 = $_POST["THU_START"];
$thu2 = $_POST["THU_END"];
$fri1 = $_POST["FRI_START"];
$fri2 = $_POST["FRI_END"];
$centerID = $_POST['CENTER_ID'];


$conn->query("DELETE FROM week_days WHERE `CLINIC_ID` = '".$clinicID."' AND CENTER_ID = '".$centerID."';");

$conn->query("INSERT INTO `week_days` 
	(CLINIC_ID,SAT_START,SAT_END,SUN_START,SUN_END,MON_START,MON_END,
	TUES_START,TUES_END,WED_START,WED_END,THU_START,THU_END,FRI_START,FRI_END,CENTER_ID) 
	VALUES('".$clinicID."' , '".$sat1."','".$sat2."','".$sun1."','".$sun2."','".$mon1."','".$mon2."','".$tue1."','".$tue2."','".$wed1."','".$wed2."','".$thu1."','".$thu2."','".$fri1."','".$fri2."','".$centerID."');");



?>