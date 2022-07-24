<?php

include 'conn.php';

$patineID = $_POST['PATIENT_ID'];

 
$res = mysqli_query($conn,"SELECT * FROM reservation WHERE PATIENT_ID = '".$patineID."' AND reservation.DATE >= CURRENT_DATE() ;");
$arr = mysqli_fetch_all($res,MYSQLI_ASSOC);

mysqli_free_result($res);

$finalArr = array();


 foreach ($arr as $item) {
	if($item['CLINIC_ID'] == -1){
		// ** CENTER **
		$centerRes = mysqli_query($conn,"SELECT `NAME`,`ADDRESS`,`CENTER_PHONE`,`SPECIALITY`,`FEE`,`CENTER_PHOTO` FROM center WHERE CENTER_ID = '".$item['CENTER_ID']."'");
		while ($row = $centerRes->fetch_assoc()) {
			$item['NAME'] = $row['NAME'];
			$item['ADDRESS'] = $row['ADDRESS'];
			$item['CENTER_PHONE'] = $row['CENTER_PHONE'];
			$item['SPECIALITY'] = $row['SPECIALITY'];
			$item['FEE'] = $row['FEE'];
			$item['CENTER_PHOTO'] = $row['CENTER_PHOTO'];
		}
		$finalArr[] = $item;
	}else{
		// ** CLINIC **
		$clinicRes = mysqli_query($conn, "SELECT CLINIC.`CLINIC_NAME`,CLINIC.`DOCTOR_ID`,CLINIC.`ADDRESS`,CLINIC.`CLINIC_PHONE`,CLINIC.`FEE`, doctor.`FIRST_NAME`,doctor.`DOCTOR_ID`, doctor.`LAST_NAME`, doctor.`SPECIALITY`,doctor.`PROFILE_PICTURE` FROM doctor, clinic WHERE clinic.CLINIC_ID = '".$item['CLINIC_ID']."' AND doctor.`DOCTOR_ID` = CLINIC.`DOCTOR_ID` ");

		while ($row = $clinicRes->fetch_assoc()) {
			$item['CLINIC_NAME'] = $row['CLINIC_NAME'];
			$item['DOCTOR_ID'] = $row['DOCTOR_ID'];
			$item['ADDRESS'] = $row['ADDRESS'];
			$item['CLINIC_PHONE'] = $row['CLINIC_PHONE'];
			$item['FEE'] = $row['FEE'];
			$item['FIRST_NAME'] = $row['FIRST_NAME'];
			$item['LAST_NAME'] = $row['LAST_NAME'];
			$item['SPECIALITY'] = $row['SPECIALITY'];
			$item['PROFILE_PICTURE'] = $row['PROFILE_PICTURE'];
		}
		$finalArr[] = $item;
	}
}


echo json_encode($finalArr);

mysqli_close($conn);

?>