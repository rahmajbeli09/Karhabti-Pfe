import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
class TechModel {
  final String? id;
  final String fullname;
  final String email;
  final String phoneNumber;
  final String password;
  final String? role;
  final double latitude;
  final double longitude;
  String? imageURL;

  TechModel({
    this.id,
    required this.email,
    required this.fullname,
    required this.phoneNumber,
    required this.password,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.role,
    this.imageURL,
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
      "imageURL": imageURL,
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
      role: data["role"],
        imageURL: data["imageURL"],
    );
  }
    // Hash the password before saving to the database
  static String hashPassword(String password) {
    final bytes = utf8.encode(password); // Convert password to bytes
    final hashedPassword = sha256.convert(bytes).toString(); // Hash the bytes
    return hashedPassword;
  }
}
