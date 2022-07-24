<?php

include '../conn.php';

$specialty = $_POST['SPECIALITY'];

$res = $conn->query("SELECT questions.QUESTION_NUM, questions.PATIENT_ID, patient.FIRST_NAME, patient.LAST_NAME,patient.PROFILE_PICTURE, questions.SPECIALITY, questions.QUESTION, questions.DATE
FROM questions LEFT JOIN answers ON questions.QUESTION_NUM= answers.QUESTION_NUM
JOIN patient ON questions.PATIENT_ID= patient.PATIENT_ID
WHERE answers.ANSWER_NUM IS NULL AND SPECIALITY = '".$specialty."'; ");

$arr = array();

while ($row = $res->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);


?>