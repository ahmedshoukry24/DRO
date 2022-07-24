<?php

include '../conn.php';

$password = $_POST['PASSWORD'];
$id = $_POST['PATIENT_ID'];

$res = $conn->query("UPDATE patient SET PASSWORD='".$password."' WHERE patient.PATIENT_ID='".$id."';");

echo json_encode($res);

?>