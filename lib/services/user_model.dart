import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String? id ;
  final String fullname ;
  final String email ;
  final String phoneNumber;
  final String password;
    final double? latitude;
  final double? longitude;
  const UserModel({
this.id,
required this.email,
required this.fullname,
required this.phoneNumber,
required this.password,
    this.latitude = 0.0,
    this.longitude = 0.0,

});
toJson(){
  return{
  "fullname" : fullname,
  "email" : email,
  "password": password,
  "phoneNumber": phoneNumber,
        "latitude": latitude,
      "longitude": longitude,
  };
}
//step1 : map user fetched from firebase to usermodel
factory UserModel.fromSnapshot(DocumentSnapshot<Map<String , dynamic>> document ){
  final data = document.data()!;
  return UserModel(
    id: document.id,
    email: data["email"] ,
     fullname: data["fullname"],
      phoneNumber: data["phoneNumber"],
       password: data["password"],
       latitude: data["latitude"] ?? 0.0,
      longitude: data["longitude"] ?? 0.0,);
}
}