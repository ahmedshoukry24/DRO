<?php

#not completed

include '../conn.php';

$res = $conn->query("SELECT questions.QUESTION_NUM, questions.PATIENT_ID, patient.FIRST_NAME, patient.LAST_NAME, questions.SPECIALITY, questions.QUESTION, questions.DATE
FROM questions LEFT JOIN answers ON questions.QUESTION_NUM= answers.QUESTION_NUM
JOIN patient ON questions.PATIENT_ID= patient.PATIENT_ID
WHERE answers.ANSWER_NUM IS NULL AND SPECIALITY = '".$specialty."'; ");

$arr = array();

while ($row = $res->) {
	# code...
}


?>