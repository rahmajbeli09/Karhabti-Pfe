import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String? id ;
  final String fullname ;
  final String email ;
  final String phoneNumber;
  final String password;

  const UserModel({
this.id,
required this.email,
required this.fullname,
required this.phoneNumber,
required this.password,
  

});
toJson(){
  return{
  "fullname" : fullname,
  "email" : email,
  "password": password,
  "phoneNumber": phoneNumber,
  };
}
//step1 : map user fetched from firebase to usermodel
factory UserModel.fromSnapshot(DocumentSnapshot<Map<String ,dynamic>> document ){
  final data = document.data()!;
  return UserModel(
    id: document.id,
    email: data["email"],
     fullname: data["fullname"],
      phoneNumber: data["phoneNumber"],
       password: data["password"]);
}
}