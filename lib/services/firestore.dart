import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirestoreService {
  final CollectionReference tryingCollection =
      FirebaseFirestore.instance.collection('trying');

  Future<void> addUser() async {
    try {
      // Create a new user with a first and last name
      final user = <String, dynamic>{
        "first": "Ada",
        "last": "Lovelace",
        "born": 1815
      };

      // Add a new document with a generated ID
      final docRef = await tryingCollection.add(user);
      print('DocumentSnapshot added with ID: ${docRef.id}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
