<?php

include '../conn.php';

$quesNum = $_POST['QUESTION_NUM'];

$res = $conn->query("SELECT answers.ANSWER_NUM,answers.QUESTION_NUM,answers.DOCTOR_ID,answers.ANSWER,answers.DATE,doctor.FIRST_NAME,doctor.LAST_NAME ,doctor.TITLE ,answers.DOCTOR_ID,doctor.PROFILE_PICTURE FROM answers,doctor WHERE doctor.DOCTOR_ID = answers.DOCTOR_ID AND answers.QUESTION_NUM = '".$quesNum."'; ");
$arr = array();

while ($row = $res->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);


?>