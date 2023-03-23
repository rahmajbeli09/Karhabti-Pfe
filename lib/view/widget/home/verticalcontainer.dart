import 'package:flutter/material.dart';

class VerticalContainer extends StatelessWidget {
  const VerticalContainer({Key? key, required this.image, required this.text, required this.color1,  required this.color2}) : super(key: key);
  final String image;
  final String text ; 
  final Color color1 ;
  final Color color2 ; 

  @override
  Widget build(BuildContext context) {
    return  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15 , vertical: 20),
                    padding: EdgeInsets.only(top: 40),
                    width: 165,
                    height: 230,
                   decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            color1,
                            color2,                            
                          ],
                        ),
                       borderRadius: BorderRadius.circular(40) 
                      ),
                  child: Column(
                    children: [
                      Center(child: Text(text , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w600 ,fontFamily: "Comfortaa", ),)),
                      SizedBox(height: 30,),
                      Image.asset(image , width: 90, height: 90,), 
                    ],
                  ),
                );
  }
}