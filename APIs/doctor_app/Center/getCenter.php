<?php

include '../conn.php';

$centerKey = $_POST['CENTER_KEY'];

$res = $conn->query("SELECT * FROM `center` WHERE `CENTER_KEY` = '".$centerKey."';");

$arr = array();

while ($row = $res->fetch_assoc()) {
	$arr[] = $row;
}

echo json_encode($arr);



?>