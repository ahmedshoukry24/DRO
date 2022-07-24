<?php
include ("../conn.php");

$query = $_POST['query'];

//$query = mysqli_real_escape_string($conn, $_POST['query'])

$res = mysqli_query($conn,$query);
$items = mysqli_fetch_all($res, MYSQLI_ASSOC);

mysqli_free_result($res);
mysqli_close($conn);

echo json_encode($items);