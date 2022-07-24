<?php

include '../conn.php';

$txt = $_POST['txt'];

$query = mysqli_query($conn,
	"SELECT * FROM doctor,clinic WHERE CONCAT( FIRST_NAME,  ' ', LAST_NAME ) LIKE  '%$txt%' AND doctor.DOCTOR_ID = clinic.DOCTOR_ID;");


$res = mysqli_fetch_all($query,MYSQLI_ASSOC);

echo json_encode($res);

?>