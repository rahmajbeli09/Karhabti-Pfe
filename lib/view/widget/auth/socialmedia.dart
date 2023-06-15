import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../controller/auth/authcontroller.dart';
import 'package:google_sign_in/google_sign_in.dart';
class SocialMedia extends StatelessWidget {
  const SocialMedia({Key? key}) : super(key: key);
// signInWithGoogle() async {
//   //reigger the authentification flow
//    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
// //obtain the auth request from the request
//  GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
// //create a new credential
// AuthCredential credential = GoogleAuthProvider.credential(
//   accessToken: googleAuth?.accessToken,
//   idToken: googleAuth?.idToken,
// );
// UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
//   print(userCredential.user?.displayName);
// }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: Image.asset("assets/images/google.png", height: 30, width: 30),
          onTap: () {
            // Call signInWithGoogle method from the authController
            // signInWithGoogle();
          },
        ),
        SizedBox(width: 20),
        InkWell(
          child: Image.asset("assets/images/facebook.png", height: 30, width: 30),
          onTap: () {
            // Implement Facebook sign-in functionality
          },
        ),
      ],
    );
  }
}
