import 'package:flutter/material.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      InkWell(child: Image.asset("assets/images/google.png",height: 30 , width: 30,),onTap: (){},),
      SizedBox(width: 20,),
      InkWell(child: Image.asset("assets/images/facebook.png",height: 30 , width: 30,),onTap: (){},),
    ]);
  }
}