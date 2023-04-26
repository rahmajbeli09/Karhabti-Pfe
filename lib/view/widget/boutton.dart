import 'package:flutter/material.dart';

class Boutton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color color ;
  const Boutton({Key? key, this.onPressed, required this.text, required this.color}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return 
    Container(
       width: double.infinity,
        decoration: BoxDecoration(
         color: color,
        borderRadius:BorderRadius.circular(50),
        ),
        margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 5 ) ,
      child: MaterialButton(onPressed:onPressed, 
            child: Text (text,style:const TextStyle(fontWeight: FontWeight.bold , fontSize: 15 , fontFamily: "Comfortaa",color: Colors.black)),

            ),
    );
  }
}