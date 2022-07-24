<?php

include 'conn.php';

$resQuery = $conn->query("SELECT * FROM patient");

$arr = array();

while ($row = $resQuery->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);



?>