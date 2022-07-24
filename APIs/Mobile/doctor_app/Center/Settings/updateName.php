<?php

include '../../conn.php';

$centerID = $_POST['CENTER_ID'];
$name = $_POST['NAME'];

$query = "UPDATE center SET NAME = '".$name."' WHERE CENTER_ID = '".$centerID."';";


echo json_encode(mysqli_query($conn,$query));

mysqli_close($conn);


?>