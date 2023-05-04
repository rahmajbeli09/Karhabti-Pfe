class TechModel{
  final String? id ;
  final String fullname ;
  final String email ;
  final String phoneNumber;
  final String password;
  final String role;

  const TechModel({
this.id,
required this.email,
required this.fullname,
required this.phoneNumber,
required this.password,
required this.role,
  

});
toJson(){
  return{
  "fullname" : fullname,
  "email" : email,
  "password": password,
  "phoneNumber": phoneNumber,
  "role": role,
  };
}
}