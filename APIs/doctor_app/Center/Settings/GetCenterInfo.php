<?php

include '../../conn.php';

$centerID = $_POST['CENTER_ID'];

$res = $conn->query("SELECT * FROM `center` WHERE `CENTER_ID` = '".$centerID."';");

$arr = mysqli_fetch_assoc($res);

echo json_encode($arr);



?>