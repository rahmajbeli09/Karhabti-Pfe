import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class VentAchCotroller extends GetxController {
  goToPostulation();
}

class VentAchCotrollerImp extends VentAchCotroller {
// void showPieceInformationDialog(String documentId) {
//   FirebaseFirestore.instance
//       .collection('pièce_de_rechange')
//       .doc(documentId)
//       .get()
//       .then((snapshot) {
//     if (snapshot.exists) {
//       final documentData = snapshot.data();
//       if (documentData != null) {
//         final String userId = documentData['userId'];

//         FirebaseFirestore.instance
//             .collection('users')
//             .doc(userId)
//             .get()
//             .then((userSnapshot) {
//           if (userSnapshot.exists) {
//             final userData = userSnapshot.data();
//             if (userData != null) {
//               final String fullName = userData['fullName'];
//               final String phoneNumber = userData['phoneNumber'];

//               // Show the dialog with the information
//               Get.dialog(
//                 AlertDialog(
//                   title: Text('Piece'),
//                   content: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Image.network(documentData['imageURL']),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 documentData['titre'],
//                                 style: TextStyle(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(height: 8),
//                               Text(
//                                 documentData['description'],
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               SizedBox(height: 8),
//                               Text(
//                                 documentData['prix'],
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.green,
//                                 ),
//                               ),
//                               SizedBox(height: 16),
//                               Text(
//                                 'User Information:',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(height: 8),
//                               Text(
//                                 'Full Name: $fullName',
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                               Text(
//                                 'Phone Number: $phoneNumber',
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }
//           }
//         });
//       }
//     }
//   });
// }


  @override
  goToPostulation() {
    Get.toNamed(AppRoute.post);
  }
}
