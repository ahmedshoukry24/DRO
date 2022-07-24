<?php

$fileName = $_POST['fileName'];
$path = $_POST['path'];

 if (file_exists("$path/$fileName")) { // =>> path of file
    unlink("$path/$fileName");
  }

  echo json_encode(true);

?>