<?php

include '../conn.php';

$specialty = $_POST['SPECIALITY'];

$res = $conn->query("SELECT questions.PATIENT_ID,questions.SPECIALITY,questions.QUESTION_NUM ,questions.QUESTION,questions.DATE,patient.FIRST_NAME,patient.LAST_NAME,patient.PROFILE_PICTURE FROM questions,patient WHERE SPECIALITY = '".$specialty."' AND patient.PATIENT_ID = questions.PATIENT_ID;");

/*
**** not used
SELECT *
FROM question
LEFT JOIN answer ON question.QUESTION_NUM = answer.QUESTION_NUM;

*/


$arr = array();

while ($row = $res->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);


?>