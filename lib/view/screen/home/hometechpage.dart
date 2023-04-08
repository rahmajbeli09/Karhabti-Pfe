
import 'package:flutter/material.dart';


import '../../widget/home/iconbuttonbar.dart';


class HomeTechPage extends StatelessWidget {
  const HomeTechPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){} , child: Icon(Icons.notifications , color: Colors.black,), backgroundColor: Colors.white,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Column(
          children: [
            Text("i'm a technicien"),
            Row(
              children: [
                Row(
                  children: [
                    IconButtonBar(icon: Icons.home_sharp,),
                    IconButtonBar(icon: Icons.car_rental_outlined)
                  ],
                ),
                Spacer(),
                Row(
              children: [
                IconButtonBar(icon: Icons.directions_car_filled_outlined),
                IconButtonBar(icon: Icons.person),
              ],
            ),
              ],
            ),
          ],
        ),
            
          ),
      body: Container()
        );
     
  }
}