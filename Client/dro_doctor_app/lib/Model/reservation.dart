class Reservation{
/*
reservation.PATIENT_ID,
reservation.CLINIC_ID, +
reservation.DATE, +
reservation.TIME, +
 patient.PATIENT_ID, +
 patient.FIRST_NAME, +
 patient.LAST_NAME, +
 patient.PHONE, +
 patient.GENDER, +
 patient.PROFILE_PICTURE +
 */
  final String firstName,lastName,img,phone,gender,patientID,clinicID,centerID,channelID;
  DateTime date;

  Reservation({this.firstName,this.lastName,this.img,
    this.date,this.gender,this.phone,this.patientID,
    this.clinicID,this.centerID,this.channelID});

}