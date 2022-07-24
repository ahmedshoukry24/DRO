<?php
include 'conn.php';


$email = $_POST['EMAIL'];
$password = $_POST['PASSWORD'];


$resQuery = $conn->query("SELECT * FROM patient WHERE EMAIL = '".$email."' AND PASSWORD = '".$password."'");

$arr = array();

while ($row = $resQuery->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);


?>