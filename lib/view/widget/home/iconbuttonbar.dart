import 'package:flutter/material.dart';

class IconButtonBar extends StatelessWidget {
  final IconData icon ;
  
  const IconButtonBar({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: (){} ,child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon) , 
              ],
            ),);
  }
}