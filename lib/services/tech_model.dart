import 'package:cloud_firestore/cloud_firestore.dart';

class TechModel {
  final String? id;
  final String fullname;
  final String email;
  final String phoneNumber;
  final String password;
  final String? role;
  final double latitude;
  final double longitude;

  TechModel({
    this.id,
    required this.email,
    required this.fullname,
    required this.phoneNumber,
    required this.password,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      "fullname": fullname,
      "email": email,
      "password": password,
      "phoneNumber": phoneNumber,
      "role": role,
      "latitude": latitude,
      "longitude": longitude,
    };
  }

  factory TechModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return TechModel(
      id: document.id,
      email: data["email"],
      fullname: data["fullname"],
      phoneNumber: data["phoneNumber"],
      password: data["password"],
      latitude: data["latitude"] ?? 0.0,
      longitude: data["longitude"] ?? 0.0,
    );
  }
}
