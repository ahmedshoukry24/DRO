<?php

include '../conn.php';

$clinicID = $_POST['clinic_id'];
$centerID = $_POST['center_id'];
$query="SELECT
reviews.patient_id as P_ID1,
reviews.clinic_id as CK_ID1,
reviews.center_id as CR_ID1,
reviews.review,
reviews.date_time,
reviews.STATUS,
ratings.patient_id as P_ID2,ratings.clinic_id as CK_ID2,ratings.rate,ratings.center_id as CR_ID2,patient.FIRST_NAME,patient.LAST_NAME,patient.PROFILE_PICTURE
from reviews
LEFT join ratings on reviews.patient_id=ratings.patient_id and ratings.clinic_id= reviews.clinic_id and ratings.center_id= reviews.center_id
JOIN patient ON patient.PATIENT_ID= reviews.patient_id
WHERE (reviews.clinic_id= '$clinicID' and reviews.center_id = '$centerID') or (ratings.clinic_id= '$clinicID' and ratings.center_id = '$centerID')
UNION
SELECT
reviews.patient_id as P_ID1,
reviews.clinic_id as CK_ID1,
reviews.center_id as CR_ID1,
reviews.review,
reviews.date_time,
reviews.STATUS,

ratings.patient_id as P_ID2,
ratings.clinic_id as CK_ID2,
ratings.rate,
ratings.center_id as CR_ID2,
patient.FIRST_NAME, patient.LAST_NAME,patient.PROFILE_PICTURE
from ratings
LEFT join reviews on reviews.patient_id=ratings.patient_id and ratings.clinic_id= reviews.clinic_id and ratings.center_id= reviews.center_id
JOIN patient ON patient.PATIENT_ID= reviews.patient_id
WHERE (reviews.clinic_id= '$clinicID' and reviews.center_id = '$centerID') or (ratings.clinic_id= '$clinicID' and ratings.center_id = '$centerID')";


$res = mysqli_query($conn, $query);
$arr = mysqli_fetch_all($res, MYSQLI_ASSOC);

mysqli_free_result($res);
mysqli_close($conn);

echo json_encode($arr);


?>