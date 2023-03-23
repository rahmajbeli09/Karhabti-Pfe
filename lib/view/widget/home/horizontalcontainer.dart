
import 'package:flutter/material.dart';

class HorizontalContainer extends StatelessWidget {
  const HorizontalContainer({Key? key,  required this.title, required this.image, required this.heur,  required this.ampm, required this.date, required this.sizedbox}) : super(key: key);
  final String title;
  final String image ; 
  final String heur;
  final String ampm ; 
  final String date ; 
  final double sizedbox ; 
  @override
  Widget build(BuildContext context) {
    return Container(
                padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 5),
                margin: EdgeInsets.symmetric(horizontal: 10 ,vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 124, 126, 124),
                            Color.fromARGB(255, 215, 209, 215),                           
                          ],
                        ),
                  borderRadius: BorderRadius.circular(25)
                ),
                height: 160,
                width: 325,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(title ,style: TextStyle(fontSize: 27, fontWeight: FontWeight.w600 ,fontFamily: "Comfortaa",),),
                        SizedBox(width: sizedbox,),
                        Image.asset( image , width: 90, height: 120,)
                      ],
                    ),
                    Row(children: [
                      Text(heur , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontFamily: "Comfortaa",),),
                      Container(child: Text(ampm , style: TextStyle(color: Colors.white ,fontFamily: "Comfortaa",),),
                       margin: EdgeInsets.symmetric(horizontal: 7),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(15) 
                        ),),
                      Container(child: Text(date, style: TextStyle(color: Colors.white , fontFamily: "Comfortaa",),), 
                       padding: EdgeInsets.all(5),
                       decoration: BoxDecoration(
                           color: Colors.blue,
                          borderRadius: BorderRadius.circular(15) 
                        ),)
                    ],)
                  ],
                ),
              );
  }
}