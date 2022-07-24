class OfflinePatient{

  String email,id,status,fName,lName;


  OfflinePatient({this.email,this.id,this.status,this.fName,this.lName});

  OfflinePatient.map(dynamic obj){
    this.email = obj['email'].toString();
    this.status = obj['status'].toString();
    this.id = obj['id'].toString();
    this.fName = obj['first_name'].toString();
    this.lName = obj['last_name'].toString();
  }

  Map<String,dynamic> toMap(){
    Map map = new Map<String,dynamic>();
    map['email'] = email;
    map['status'] = status;
    map['id'] = id;
    map['first_name'] = fName;
    map['last_name'] = lName;
    return map;
  }

  OfflinePatient.fromMap(Map<String,dynamic> map){
    this.id = map['id'].toString();
    this.status = map['status'].toString();
    this.email = map['email'].toString();
    this.fName = map['first_name'].toString();
    this.lName = map['last_name'].toString();
  }
}