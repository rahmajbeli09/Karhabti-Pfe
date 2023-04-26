//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomButtomAuth extends StatelessWidget {
  
  final String text;
  final void Function()? onPressed;
  const CustomButtomAuth({Key? key, required this.text, this.onPressed})
      : super(key: key);
      //i added the method below
   //Future signIn() async {
   // await FirebaseAuth.instance.signInWithEmailAndPassword(
     // email: email.text.trim(),
     // password: password.text.trim(),
   // );
 // }
 
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      padding:const EdgeInsets.symmetric(vertical: 10 , horizontal: 70),
      onPressed: onPressed,
      color: Colors.white,
      child: Text(text , style:const TextStyle(fontWeight: FontWeight.bold , fontSize: 15 , fontFamily: "Comfortaa",)),
    );
  }
}
