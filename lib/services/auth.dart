import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:karhabti_pfe/view/screen/pageone.dart';

import '../view/screen/auth/login.dart';

class AuthService {
final FirebaseAuth _auth = FirebaseAuth.instance ;
final GoogleSignIn _googleSignIn = GoogleSignIn();
//création d'une fonction permettant de se connecter avec google

Future<UserCredential> signInWithGoogle() async{
  //déclencher le flux d'authentification
  final googleUser = await _googleSignIn.signIn();
  //obtenir les détails d'autorisation de la demande
  final googleauth = await googleUser!.authentication; //le point d'excalamation pour dire que la variable ne doit pas etre nulle
  //créer un nouvel identifiant
  final credential = GoogleAuthProvider.credential(
    accessToken: googleauth.accessToken,
    idToken: googleauth.idToken,
  );
  //une fois connecté , renvoyer l'id de l'utilisateur
  return await _auth.signInWithCredential(credential);
//l'etat de l'utilisateur en temps réel 
 Stream<User?> get; user()=> _auth.authStateChanges(); //turned this into a comment because of its prob

}
}