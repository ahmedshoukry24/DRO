<?php

include '../conn.php';

$id = $_POST['DOCTOR_ID'];
$password = $_POST['PASSWORD'];

$res = $conn -> query("UPDATE doctor SET PASSWORD='".$password."' WHERE doctor.DOCTOR_ID='".$id."';");

echo json_encode($res);



?>