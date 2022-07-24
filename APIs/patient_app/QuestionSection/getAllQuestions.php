<?php

include '../conn.php';


$res = $conn->query("SELECT questions.PATIENT_ID,questions.SPECIALITY,questions.QUESTION_NUM ,questions.QUESTION,questions.DATE,patient.FIRST_NAME,patient.LAST_NAME,patient.PROFILE_PICTURE FROM questions,patient WHERE SPECIALITY IS NOT NULL AND patient.PATIENT_ID = questions.PATIENT_ID order by DATE desc;");


$arr = array();

while ($row = $res->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);


?>