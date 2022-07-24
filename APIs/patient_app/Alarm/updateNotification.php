<?php
include '../conn.php';

$alarmID = $_POST['ALARM_ID'];

$conn->query("UPDATE alarm SET `STATUS` = 'D' WHERE `ALARM_ID` = '".$alarmID."'");

?>