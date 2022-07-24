<?php
include 'conn.php';

$query = mysqli_query($conn,'SELECT offers.CLINIC_ID, offers.CENTER_ID, offers.CONTENT, offers.FIGURE_NAME, offers.DATE_TIME,clinic.ADDRESS CLINIC_ADDRESS, center.ADDRESS CENTER_ADDRESS FROM offers,clinic,center WHERE offers.CLINIC_ID = clinic.CLINIC_ID AND offers.CENTER_ID = center.CENTER_ID');

$res = mysqli_fetch_all($query,MYSQLI_ASSOC);

echo json_encode($res);

?>