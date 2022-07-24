<?php

include '../conn.php';

$questtionNum = $_POST['QUESTION_NUM'];
$doctorID = $_POST['DOCTOR_ID'];
$answer = $_POST['ANSWER'];
$date = $_POST['DATE'];


$res = $conn ->query("INSERT INTO `answers` (`QUESTION_NUM`, `DOCTOR_ID`, `ANSWER`, `DATE`) VALUES ('".$questtionNum."', '".$doctorID."', '".$answer."', '".$date."');");

echo json_encode($res);

?>