<?php

include '../conn.php';

$patientID = $_POST['patient_id'];
$clinicID = $_POST['clinic_id'];
$review = addslashes($_POST['review']);
$date = $_POST['date_time'];
$status = $_POST['STATUS'];
$centerID = $_POST['center_id'];



$res = $conn->query("INSERT INTO `reviews` (`patient_id`, `clinic_id`,`center_id`, `review`,`STATUS`,`date_time`)
 VALUES ('".$patientID."', '".$clinicID."','".$centerID."','".$review."','".$status."', '".$date."');");

//mysqli_free_result($res);

//mysqli_close($conn);


echo json_encode($res);

?>