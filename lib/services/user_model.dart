import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class UserModel {
  final String? id;
  final String email;
  final String fullname;
  final String phoneNumber;
  final String password; // Store hashed password
  final double? latitude;
  final double? longitude;
  String? imageURL;

  UserModel({
    this.id,
    required this.email,
    required this.fullname,
    required this.phoneNumber,
    required this.password,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.imageURL,
  });

  Map<String, dynamic> toJson() {
    return {
      "fullname": fullname,
      "email": email,
      "password": password, // Store hashed password
      "phoneNumber": phoneNumber,
      "latitude": latitude,
      "longitude": longitude,
      "imageURL": imageURL,
    };
  }

  // Step 1: Map user fetched from Firebase to UserModel
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      email: data["email"],
      fullname: data["fullname"],
      phoneNumber: data["phoneNumber"],
      password: data["password"],
      latitude: data["latitude"] ?? 0.0,
      longitude: data["longitude"] ?? 0.0,
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

